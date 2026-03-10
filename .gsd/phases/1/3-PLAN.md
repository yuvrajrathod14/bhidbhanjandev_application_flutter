---
phase: 1
plan: 3
wave: 2
---

# Plan 1.3: Onboarding Screens

## Objective
Implement a 3-slide onboarding carousel introducing new users to the app features, with "Skip" and "Get Started" buttons.

## Context
- .gsd/SPEC.md
- lib/features/auth/screens/onboarding_screen.dart

## Tasks

<task type="auto">
  <name>Implement Onboarding UI</name>
  <files>lib/features/auth/screens/onboarding_screen.dart</files>
  <action>
    - Create `OnboardingScreen` using `PageView`.
    - Slide 1: Welcome to Temple (spiritual companion text).
    - Slide 2: Stay Updated (Aarti, festivals info).
    - Slide 3: Join Community (notifications & updates).
    - Add a bottom row with a Page Indicator (dots) and a "Skip" / "Get Started" button that navigates to `LoginScreen` (placeholder).
  </action>
  <verify>flutter analyze lib/features/auth/screens/onboarding_screen.dart</verify>
  <done>Onboarding screen with 3 slides implemented and swipeable.</done>
</task>

<task type="auto">
  <name>Integrate Shared Preferences for First Launch</name>
  <files>pubspec.yaml, lib/core/utils/prefs_util.dart, lib/features/auth/screens/splash_screen.dart</files>
  <action>
    - Add `shared_preferences` package to `pubspec.yaml`.
    - Create a utility class `PrefsUtil` to save/read a boolean `isFirstTimeUser` (default true).
    - When "Get Started" or "Skip" is clicked on onboarding, set `isFirstTimeUser` to false.
    - Update `SplashScreen` to use `PrefsUtil`: if first time, navigate to Onboarding, else navigate to Login.
  </action>
  <verify>flutter pub get && flutter analyze</verify>
  <done>App remembers if the user has completed onboarding.</done>
</task>

## Success Criteria
- [ ] 3-slide onboarding works correctly.
- [ ] `shared_preferences` remembers user state.
