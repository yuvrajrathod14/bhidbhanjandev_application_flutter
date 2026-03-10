import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/prefs_util.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingSlide> _slides = const [
    _OnboardingSlide(
      icon: Icons.temple_hindu,
      titleTop: 'Experience',
      titleHighlight: 'Divine Peace',
      greeting: 'Jay Swaminarayan',
      description:
          'Embark on a spiritual journey, stay connected with daily darshan and wisdom.',
    ),
    _OnboardingSlide(
      icon: Icons.notifications_active,
      titleTop: 'Stay',
      titleHighlight: 'Updated',
      greeting: 'દર્શન અને આરતી',
      description:
          'Aarti timings, festivals, live darshan, and more — always at your fingertips.',
    ),
    _OnboardingSlide(
      icon: Icons.people,
      titleTop: 'Join Our',
      titleHighlight: 'Community',
      greeting: 'અમારી સાથે જોડાઓ',
      description:
          'Get personalized notifications, event reminders, and temple updates.',
    ),
  ];

  void _finishOnboarding() async {
    await PrefsUtil.setFirstTimeUser(false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, _, _) => const LoginScreen(),
        transitionsBuilder: (_, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Skip Button ──
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 4),
                child: TextButton(
                  onPressed: _finishOnboarding,
                  child: Text(
                    'Skip',
                    style: GoogleFonts.newsreader(
                      color: AppTheme.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),

            // ── PageView ──
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ── Illustration Card ──
                        Container(
                          width: double.infinity,
                          height: 260,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppTheme.primaryColor.withAlpha(26),
                            border: Border.all(
                              color: AppTheme.primaryColor.withAlpha(26),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(18),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Bottom gradient overlay
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        AppTheme.backgroundColor.withAlpha(204),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Icon(
                                  slide.icon,
                                  size: 120,
                                  color: AppTheme.primaryColor.withAlpha(128),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // ── Title ──
                        Text(
                          slide.titleTop,
                          style: GoogleFonts.newsreader(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                            height: 1.15,
                          ),
                        ),
                        Text(
                          slide.titleHighlight,
                          style: GoogleFonts.newsreader(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                            height: 1.15,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // ── Greeting ──
                        Text(
                          slide.greeting,
                          style: GoogleFonts.newsreader(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            color: AppTheme.textDark.withAlpha(230),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ── Description ──
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            slide.description,
                            style: GoogleFonts.newsreader(
                              fontSize: 16,
                              color: AppTheme.textMuted,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ── Footer: Dots + Button ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: Column(
                children: [
                  // Progress dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: _currentPage == i ? 10 : 8,
                        width: _currentPage == i ? 32 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == i
                              ? AppTheme.primaryColor
                              : AppTheme.primaryColor.withAlpha(77),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Next / Get Started button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _slides.length - 1) {
                          _finishOnboarding();
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadowColor: AppTheme.primaryColor.withAlpha(100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == _slides.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: GoogleFonts.newsreader(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlide {
  final IconData icon;
  final String titleTop;
  final String titleHighlight;
  final String greeting;
  final String description;

  const _OnboardingSlide({
    required this.icon,
    required this.titleTop,
    required this.titleHighlight,
    required this.greeting,
    required this.description,
  });
}
