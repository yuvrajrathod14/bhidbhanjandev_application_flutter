import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/prefs_util.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'onboarding_screen.dart';
import 'login_screen.dart';
import '../../home/screens/main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _glowController;

  // Main sequence animations
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double> _titleSlide;
  late final Animation<double> _titleFade;
  late final Animation<double> _quoteFade;
  late final Animation<double> _progressFill;

  // Glow pulse loop
  late final Animation<double> _glowPulse;

  bool _animationCompleted = false;
  bool _navigationTriggered = false;

  @override
  void initState() {
    super.initState();

    // Main sequence timeline
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // Glow looping pulse
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    // 0–40%: Logo fades & scales in
    _logoFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    _logoScale = Tween(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );

    // 30–60%: Title slides up & fades
    _titleSlide = Tween(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.6, curve: Curves.easeOut),
      ),
    );
    _titleFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.6, curve: Curves.easeOut),
      ),
    );

    // 50–80%: Quote fades in
    _quoteFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    // 60–100%: Progress bar fills
    _progressFill = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );

    _glowPulse = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _mainController.forward();

    // Navigate after animation finishes
    _mainController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          setState(() => _animationCompleted = true);
          _checkAndNavigate();
        }
      }
    });
  }

  void _checkAndNavigate() {
    if (!mounted || _navigationTriggered) return;

    final authState = context.read<AuthBloc>().state;
    // Don't navigate while still in initial state
    if (authState is AuthInitial) return;

    // We only navigate if animation is done
    if (_animationCompleted) {
      _navigationTriggered = true;
      _performNavigation(authState);
    }
  }

  void _performNavigation(AuthState state) {
    final isFirstTime = PrefsUtil.isFirstTimeUser;

    Widget destination;
    if (isFirstTime) {
      destination = const OnboardingScreen();
    } else if (state is Authenticated) {
      destination = const MainShell();
    } else {
      destination = const LoginScreen();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, _, _) => destination,
        transitionsBuilder: (_, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _mainController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) => _checkAndNavigate(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF5993D), Color(0xFFE68A30), Color(0xFFC26D1D)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),

                // ── Temple Logo with Glow ──
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _mainController,
                    _glowController,
                  ]),
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _logoFade,
                      child: ScaleTransition(
                        scale: _logoScale,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withAlpha(
                                  (_glowPulse.value * 100).toInt(),
                                ),
                                blurRadius: 60,
                                spreadRadius: 15,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/temple_logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),

                // ── Temple Name ──
                AnimatedBuilder(
                  animation: _mainController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _titleSlide.value),
                      child: Opacity(
                        opacity: _titleFade.value,
                        child: Column(
                          children: [
                            Text(
                              'श्री भीडभंजन देव',
                              style: GoogleFonts.newsreader(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Gradient divider
                            Container(
                              width: 80,
                              height: 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withAlpha(0),
                                    Colors.white,
                                    Colors.white.withAlpha(0),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'સાકરિયા • તા. મોડાસા • જિ. અરવલ્લી',
                              style: GoogleFonts.newsreader(
                                fontSize: 14,
                                color: Colors.white.withAlpha(204),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // ── Quote ──
                AnimatedBuilder(
                  animation: _mainController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _quoteFade.value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          '"जय श्री राम • ॐ हनुમતે નમઃ"',
                          style: GoogleFonts.newsreader(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.white.withAlpha(179),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),

                const Spacer(flex: 2),

                // ── Animated Progress Bar ──
                AnimatedBuilder(
                  animation: _mainController,
                  builder: (context, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: SizedBox(
                          height: 4,
                          child: LinearProgressIndicator(
                            value: _progressFill.value,
                            backgroundColor: Colors.white.withAlpha(51),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
