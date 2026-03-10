---
phase: 2
plan: 4
wave: 3
---

# Plan 2.4: Temple Info & Facilities

## Objective
Provide static content regarding temple history, rules, and available facilities to help visitors.

## Context
- `.gsd/SPEC.md`
- `lib/features/info/screens/info_screen.dart` (Create new if not exist)
- `lib/features/home/screens/main_shell.dart` (Ensure App Drawer can route here)

## Tasks

<task type="auto">
  <name>Build Temple Info Screen</name>
  <files>
    - lib/features/info/screens/info_screen.dart
    - lib/features/home/widgets/app_drawer.dart
  </files>
  <action>
    - Create `info_screen.dart` containing multiple tabs or sections: History, Facilities (Parking, Shoes, Prasad), Rules (Dress code, Photography).
    - Use `ExpansionTile` or a simple `ListView` with Headers for this content.
    - Update `AppDrawer` to include a "Temple Info" tile that navigates to this new screen using `Navigator.push`.
  </action>
  <verify>flutter analyze</verify>
  <done>Info screen is accessible from the drawer and displays the mandated content sections.</done>
</task>

## Success Criteria
- [ ] Dedicated screen for Temple Information.
- [ ] Content includes History, Facilities, and Rules.
- [ ] Navigation from App Drawer works.
