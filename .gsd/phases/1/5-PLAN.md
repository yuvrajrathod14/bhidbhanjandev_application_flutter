---
phase: 1
plan: 5
wave: 4
---

# Plan 1.5: Main Navigation Shell

## Objective
Implement the persistent Bottom Navigation Bar and App Drawer, establishing the skeleton for the 5 main tabs.

## Context
- .gsd/SPEC.md
- lib/features/home/screens/main_shell.dart

## Tasks

<task type="auto">
  <name>Implement Main Navigation Shell</name>
  <files>lib/features/home/screens/main_shell.dart, lib/features/home/widgets/app_drawer.dart</files>
  <action>
    - Create `MainShell` stateful widget handling a `BottomNavigationBar` with 5 tabs: Home, Timings, Events, Gallery, More.
    - Create placeholder screens for each of these 5 tabs.
    - Create `AppDrawer` widget containing the hamburger menu items (Home, Timings, Events, Gallery, Blog, Facilities, Donate, Settings, etc.).
    - When `AuthBloc` state is `Authenticated`, navigate to `MainShell`.
  </action>
  <verify>flutter analyze lib/features/home/</verify>
  <done>Main Shell widget built with BottomNavigationBar and App Drawer.</done>
</task>

## Success Criteria
- [ ] Bottom Navigation Bar switches tabs correctly.
- [ ] App Drawer is accessible and displays menu items.
- [ ] Successful login navigates to the `MainShell`.
