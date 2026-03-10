---
phase: 2
plan: 2
wave: 2
---

# Plan 2.2: Aarti Timings UI

## Objective
Provide a clear, readable daily schedule for temple timings (Darshan, Aarti, Thal, etc.).

## Context
- `.gsd/SPEC.md`
- `lib/features/timings/screens/timings_screen.dart` (Currently a placeholder)
- `lib/features/timings/widgets/timing_card.dart`

## Tasks

<task type="auto">
  <name>Build Timings UI and Data Models</name>
  <files>
    - lib/features/timings/models/timing_info.dart
    - lib/features/timings/screens/timings_screen.dart
    - lib/features/timings/widgets/timing_card.dart
  </files>
  <action>
    - Create `timing_info.dart` with fields: title (e.g., Mangla Aarti), time (e.g., 5:30 AM), description, icon.
    - Create dummy data for standard daily temple timings.
    - In `timings_screen.dart`, implement a `ListView.builder` to display these timings.
    - Create `timing_card.dart` to render each timing beautifully, showing the title, time prominently, and a subtle icon.
  </action>
  <verify>flutter analyze</verify>
  <done>Timings screen shows a scrollable list of daily temple schedule items.</done>
</task>

## Success Criteria
- [ ] `TimingsScreen` replaces generic placeholder.
- [ ] A clean list of daily events is visible.
- [ ] The `TimingCard` design utilizes the theme colors appropriately.
