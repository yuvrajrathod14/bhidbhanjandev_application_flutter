---
phase: 2
plan: 1
wave: 1
---

# Plan 2.1: Home Dashboard & Status Card

## Objective
Implement the central landing screen (`HomeScreen`) that provides devotees with a quick overview of the temple's current status, upcoming aarti, and quick links to other sections.

## Context
- `.gsd/SPEC.md`
- `lib/features/home/screens/home_screen.dart` (Currently a placeholder)
- `lib/core/theme/app_theme.dart`

## Tasks

<task type="auto">
  <name>Build Home Dashboard UI</name>
  <files>
    - lib/features/home/screens/home_screen.dart
    - lib/features/home/widgets/status_card.dart
    - lib/features/home/widgets/quick_links_grid.dart
  </files>
  <action>
    - Update `home_screen.dart` to use a `CustomScrollView` with `SliverAppBar` (pinned, snapping) showing a beautiful temple header image.
    - Create `status_card.dart` to display the "Next Aarti" or current temple open/close status. Use a gradient background and an icon.
    - Create `quick_links_grid.dart` showing a 2x2 or 3x2 grid of icon buttons navigating to Timings, Events, Gallery, Donation.
    - Assemble these widgets in the `HomeScreen` body.
  </action>
  <verify>flutter analyze</verify>
  <done>HomeScreen displays a header, a status card, and a grid of quick links without layout overflow errors.</done>
</task>

## Success Criteria
- [ ] `HomeScreen` safely replaces the generic placeholder.
- [ ] Status card prominent near the top.
- [ ] Quick links grid is responsive and visually aligned with AppTheme.
