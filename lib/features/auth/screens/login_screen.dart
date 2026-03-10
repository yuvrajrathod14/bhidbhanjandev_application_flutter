import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'register_screen.dart';
import '../../home/screens/main_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _obscurePassword = true;
  bool _isPhoneMode = false;
  String? _verificationId;

  late AnimationController _animController;
  late Animation<double> _headerFade;
  late Animation<Offset> _formSlide;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _headerFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _formSlide = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animController,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _animController.forward();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  void _googleSignIn() {
    context.read<AuthBloc>().add(GoogleSignInRequested());
  }

  void _phoneSignIn() {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a phone number')),
      );
      return;
    }
    context.read<AuthBloc>().add(
      PhoneAuthRequested(phoneNumber: _phoneController.text.trim()),
    );
  }

  void _verifyOtp() {
    if (_otpController.text.isEmpty || _verificationId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter the OTP')));
      return;
    }
    context.read<AuthBloc>().add(
      OtpSubmitted(
        verificationId: _verificationId!,
        smsCode: _otpController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainShell()),
            );
          } else if (state is OtpSent) {
            setState(() {
              _verificationId = state.verificationId;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('OTP sent successfully! Tap verify below.'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is AuthError) {
            String message = state.message;
            if (message.contains('10') ||
                message.toLowerCase().contains('developer error')) {
              message =
                  'Login Error: Please ensure SHA-1 fingerprint is added to Firebase Console.';
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red.shade700,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // ═══ TOP: Branded Header ═══
                FadeTransition(
                  opacity: _headerFade,
                  child: _buildBrandedHeader(),
                ),

                // ═══ MIDDLE: Form Area ═══
                SlideTransition(
                  position: _formSlide,
                  child: Container(
                    transform: Matrix4.translationValues(0, -16, 0),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (!_isPhoneMode) ...[
                            // Email Input
                            _buildLabel('Email Address'),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.newsreader(fontSize: 16),
                              decoration: AppTheme.styledInput(
                                label: '',
                                hint: 'Enter your email',
                                icon: Icons.person_outline,
                              ),
                              validator: (v) {
                                if (!_isPhoneMode) {
                                  if (v == null || v.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!v.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            // Password Input
                            _buildLabel('Password'),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: GoogleFonts.newsreader(fontSize: 16),
                              decoration: AppTheme.styledInput(
                                label: '',
                                hint: 'Enter your password',
                                icon: Icons.lock_outline,
                                suffix: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppTheme.textMuted,
                                    size: 20,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  ),
                                ),
                              ),
                              validator: (v) {
                                if (!_isPhoneMode) {
                                  if (v == null || v.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (v.length < 6) {
                                    return 'At least 6 characters';
                                  }
                                }
                                return null;
                              },
                            ),
                          ] else if (_verificationId == null) ...[
                            // Phone Input
                            _buildLabel('Phone Number'),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: GoogleFonts.newsreader(fontSize: 16),
                              decoration: AppTheme.styledInput(
                                label: '',
                                hint: '+91 99999 99999',
                                icon: Icons.smartphone_outlined,
                              ),
                              validator: (v) {
                                if (_isPhoneMode && _verificationId == null) {
                                  if (v == null || v.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                }
                                return null;
                              },
                            ),
                          ] else ...[
                            // OTP Input
                            _buildLabel('Verification Code'),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _otpController,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.newsreader(fontSize: 16),
                              decoration: AppTheme.styledInput(
                                label: '',
                                hint: 'Enter 6-digit OTP',
                                icon: Icons.lock_clock_outlined,
                              ),
                              validator: (v) {
                                if (_verificationId != null) {
                                  if (v == null || v.isEmpty) {
                                    return 'Please enter the OTP';
                                  }
                                  if (v.length != 6) {
                                    return 'Must be 6 digits';
                                  }
                                }
                                return null;
                              },
                            ),
                          ],

                          if (!_isPhoneMode)
                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Forgot Password flow coming soon!',
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.newsreader(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),

                          if (_isPhoneMode && _verificationId != null)
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _verificationId = null;
                                  });
                                },
                                child: Text(
                                  'Change Number?',
                                  style: GoogleFonts.newsreader(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),

                          const SizedBox(height: 8),

                          // Login Button
                          SizedBox(
                            height: 56,
                            child: state is AuthLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppTheme.primaryColor,
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      if (_isPhoneMode) {
                                        if (_verificationId == null) {
                                          _phoneSignIn();
                                        } else {
                                          _verifyOtp();
                                        }
                                      } else {
                                        _login();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _isPhoneMode
                                              ? (_verificationId == null
                                                    ? 'Send OTP'
                                                    : 'Verify OTP')
                                              : 'Login',
                                          style: GoogleFonts.newsreader(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.arrow_forward,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),

                          const SizedBox(height: 28),

                          // ─── Divider ───
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppTheme.primaryColor.withAlpha(51),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'Or continue with',
                                  style: GoogleFonts.newsreader(
                                    color: AppTheme.textMuted,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppTheme.primaryColor.withAlpha(51),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // ─── Social Login Buttons ───
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: state is AuthLoading
                                      ? null
                                      : _googleSignIn,
                                  icon: Icon(
                                    Icons.mail_outline,
                                    color: Colors.red.shade600,
                                    size: 20,
                                  ),
                                  label: Text(
                                    'Google',
                                    style: GoogleFonts.newsreader(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textDark,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    side: BorderSide(
                                      color: AppTheme.primaryColor.withAlpha(
                                        51,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _isPhoneMode = !_isPhoneMode;
                                      _verificationId = null;
                                    });
                                  },
                                  icon: Icon(
                                    _isPhoneMode
                                        ? Icons.mail_outline
                                        : Icons.smartphone,
                                    color: AppTheme.primaryColor,
                                    size: 20,
                                  ),
                                  label: Text(
                                    _isPhoneMode ? 'Email' : 'Phone',
                                    style: GoogleFonts.newsreader(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textDark,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    side: BorderSide(
                                      color: AppTheme.primaryColor.withAlpha(
                                        51,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // ─── Register Link ───
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: GoogleFonts.newsreader(
                                  color: AppTheme.textMuted,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterScreen(),
                                  ),
                                ),
                                child: Text(
                                  'Register',
                                  style: GoogleFonts.newsreader(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBrandedHeader() {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withAlpha(26),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Stack(
        children: [
          // Mandala circles pattern
          Positioned(
            top: -40,
            left: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryColor.withAlpha(26),
                  width: 1,
                ),
              ),
            ),
          ),
          Positioned(
            top: -20,
            right: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryColor.withAlpha(18),
                  width: 1,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: 60,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryColor.withAlpha(13),
                  width: 1,
                ),
              ),
            ),
          ),

          // Blur overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
                color: AppTheme.backgroundColor.withAlpha(153),
              ),
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Glowing icon circle
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withAlpha(128),
                        blurRadius: 30,
                        spreadRadius: 0,
                      ),
                    ],
                    border: Border.all(
                      color: AppTheme.primaryColor.withAlpha(77),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.self_improvement,
                    size: 44,
                    color: AppTheme.primaryColor,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Welcome Back',
                  style: GoogleFonts.newsreader(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Namaste, please login to continue',
                  style: GoogleFonts.newsreader(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.newsreader(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppTheme.textDark.withAlpha(179),
      ),
    );
  }
}
