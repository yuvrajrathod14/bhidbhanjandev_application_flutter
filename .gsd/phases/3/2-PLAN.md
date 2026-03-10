---
phase: 3
plan: 2
wave: 2
---

# Plan 3.2: Gallery Tab

## Objective
Provide an image gallery to showcase temple festivals, daily Darshan, and architecture.

## Context
- `ROADMAP.md` (Phase 3)
- `lib/features/gallery/screens/gallery_screen.dart`

## Tasks

<task type="auto">
  <name>Build Media Gallery Grid</name>
  <files>
    - lib/features/gallery/screens/gallery_screen.dart
    - lib/features/gallery/widgets/gallery_grid_item.dart
  </files>
  <action>
    - Create a staggered GridView or standard GridView for image thumbnails.
    - Add a simple photo viewer modal using `Hero` animation for clicking an image.
  </action>
  <verify>flutter analyze</verify>
  <done>Gallery tab shows a working grid of images that can be expanded.</done>
</task>

## Success Criteria
- [ ] Grid of images is viewable in the Gallery tab.
- [ ] Tapping an image enlarges it.
