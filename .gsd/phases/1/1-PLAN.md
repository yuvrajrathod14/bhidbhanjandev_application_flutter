---
phase: 1
plan: 1
wave: 1
---

# Plan 1.1: Project Initialization & Architecture

## Objective
Initialize the Flutter project for Shree Bhidbhanjan Hanuman Temple app and set up the feature-first directory structure. 

## Context
- .gsd/SPEC.md
- .gsd/ROADMAP.md
- .gsd/RESEARCH.md

## Tasks

<task type="auto">
  <name>Create Flutter Project</name>
  <files>pubspec.yaml, lib/main.dart</files>
  <action>
    - Ensure you are in the d:\1a\Bhidbhanjandev directory.
    - If a flutter project is not already created, run `flutter create --org com.bhidbhanjan.temple --project-name bhidbhanjan_app .`
    - Update pubspec.yaml with app description ("Shree Bhidbhanjan Hanuman Temple App").
  </action>
  <verify>flutter pub get && flutter analyze</verify>
  <done>Flutter project successfully initialized and `pubspec.yaml` updated.</done>
</task>

<task type="auto">
  <name>Setup Folder Architecture</name>
  <files>lib/</files>
  <action>
    - Create the Feature-First directory structure inside `lib/`.
    - Create `core/theme`, `core/constants`, `core/utils`.
    - Create `features/auth`, `features/home`, `features/timings`, `features/events`, `features/gallery`, `features/blog`, `features/info`, `features/donation`, `features/profile`, `features/search`.
    - Create `data/services` and `data/models`.
  </action>
  <verify>Get-ChildItem -Path lib/features</verify>
  <done>All necessary directories for the 24-screen architecture are created.</done>
</task>

## Success Criteria
- [ ] Flutter project created and compiles.
- [ ] Feature-first folder structure is present in `lib/`.
