---
phase: 2
plan: 3
wave: 2
---

# Plan 2.3: Calendar & Local Reminders

## Objective
Allow devotees to set local push notification reminders and add specific Aartis or events directly to their device's calendar.

## Context
- `.gsd/SPEC.md`
- `lib/features/timings/screens/timings_screen.dart`
- `pubspec.yaml`

## Tasks

<task type="auto">
  <name>Integrate Calendar and Notification Packages</name>
  <files>
    - pubspec.yaml
    - lib/core/utils/notification_util.dart
    - lib/features/timings/widgets/timing_card.dart
  </files>
  <action>
    - Run `flutter pub add flutter_local_notifications add_2_calendar`.
    - Create `notification_util.dart` to initialize local notifications (request permissions for Android 13+/iOS).
    - Update `TimingCard` to include a "Remind Me" button and an "Add to Calendar" button.
    - Implement the logic to create a local scheduled notification (15 mins before the time) and an intent to add to the system calendar.
  </action>
  <verify>flutter pub get && flutter analyze</verify>
  <done>Packages are installed and NotificationUtil functions compile. Buttons present on TimingCard.</done>
</task>

## Success Criteria
- [ ] `flutter_local_notifications` and `add_2_calendar` added.
- [ ] Utility class for scheduling notifications exists.
- [ ] Action buttons are wired up in the Timing UI.
