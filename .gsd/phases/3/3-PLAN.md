---
phase: 3
plan: 3
wave: 3
---

# Plan 3.3: Blog/News Tab

## Objective
Keep devotees informed with temple announcements, spiritual blogs, and community news.

## Context
- `ROADMAP.md` (Phase 3)
- App Drawer navigation.

## Tasks

<task type="auto">
  <name>Build Blog/News Section</name>
  <files>
    - lib/features/blog/models/post_model.dart
    - lib/features/blog/screens/blog_screen.dart
    - lib/features/blog/widgets/post_card.dart
  </files>
  <action>
    - Create `PostModel` (id, title, excerpt, content, publication date, author).
    - Build `BlogScreen` representing a newsfeed.
    - Route the AppDrawer's "Blog & News" option to `BlogScreen`.
  </action>
  <verify>flutter analyze</verify>
  <done>Blog/News screen operates correctly and presents articles.</done>
</task>

## Success Criteria
- [ ] Dedicated Blog screen viewable from App Drawer.
- [ ] Formatted post cards displaying news excerpts.
