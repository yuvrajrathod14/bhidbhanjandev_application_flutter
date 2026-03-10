---
phase: 1
plan: 2
wave: 2
---

# Plan 1.2: Core Theme & Splash Screen

## Objective
Establish the global theme (Saffron and Cream) and implement the Splash Screen with an animated Om symbol and temple branding.

## Context
- .gsd/SPEC.md
- lib/core/theme/app_theme.dart
- lib/features/auth/screens/splash_screen.dart

## Tasks

<task type="auto">
  <name>Setup App Theme</name>
  <files>lib/core/theme/app_theme.dart, lib/main.dart</files>
  <action>
    - Create `AppTheme` class with a light theme holding primary Saffron (e.g. 0xFFFF9933) and Cream background colors.
    - Set up default TextTheme suitable for both English and Gujarati.
    - Apply this theme in `main.dart`'s MaterialApp.
  </action>
  <verify>flutter analyze lib/core/theme/app_theme.dart</verify>
  <done>AppTheme class defined and applied in `main.dart`.</done>
</task>

<task type="auto">
  <name>Implement Splash Screen</name>
  <files>lib/features/auth/screens/splash_screen.dart</files>
  <action>
    - Create a stateful widget `SplashScreen`.
    - Design UI with a gradient background (Saffron to Cream), a large "ॐ" symbol, and the Temple name ("Shree Bhidbhanjan Hanuman Temple") in both English and Gujarati ("શ્રી ભીડભંજન હનુમાન મંદિર").
    - Add a loading indicator at the bottom.
    - Add a 3-second delay, then navigate to `OnboardingScreen` (which will be a placeholder initially).
  </action>
  <verify>flutter analyze lib/features/auth/screens/splash_screen.dart</verify>
  <done>Splash screen UI implemented with timer-based navigation.</done>
</task>

## Success Criteria
- [ ] App theme has saffron/cream colors.
- [ ] Splash screen displays branding and transitions automatically.
