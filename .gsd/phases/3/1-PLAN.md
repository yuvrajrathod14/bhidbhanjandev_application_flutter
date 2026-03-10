---
phase: 3
plan: 1
wave: 1
---

# Plan 3.1: Events UI & Data Model

## Objective
Display upcoming and past temple events in a list, with a detail view providing comprehensive information.

## Context
- `ROADMAP.md` (Phase 3)
- `lib/features/events/screens/events_screen.dart`
- Firebase Firestore will eventually back this, but for now we need a robust mock model.

## Tasks

<task type="auto">
  <name>Build Events Models and Screen</name>
  <files>
    - lib/features/events/models/event_model.dart
    - lib/features/events/screens/events_screen.dart
    - lib/features/events/widgets/event_card.dart
  </files>
  <action>
    - Create `EventModel` with id, title, description, date, type (festival, puja, etc).
    - Create `EventCard` widget to display an event elegantly.
    - Update `EventsScreen` to show a `ListView` of `EventCard`s.
    - Add a `DefaultTabController` if separating 'Upcoming' vs 'Past' events.
  </action>
  <verify>flutter analyze</verify>
  <done>Events tab shows a populated list of upcoming temple events.</done>
</task>

## Success Criteria
- [ ] List of events is displayed on the third Navigation Bar tab.
- [ ] Clean and distinct UI for events versus normal Aarti timings.
