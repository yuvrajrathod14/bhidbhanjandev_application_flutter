---
phase: 1
plan: 4
wave: 3
---

# Plan 1.4: Authentication UI & Logic

## Objective
Implement Login and Register screens and integrate Firebase Authentication (Email/Password & Google Sign-In).

## Context
- .gsd/SPEC.md
- lib/features/auth/screens/login_screen.dart
- lib/features/auth/screens/register_screen.dart
- lib/features/auth/bloc/auth_bloc.dart

## Tasks

<task type="auto">
  <name>Implement Auth UI (Login & Register)</name>
  <files>lib/features/auth/screens/login_screen.dart, lib/features/auth/screens/register_screen.dart</files>
  <action>
    - Create `LoginScreen` with email/phone & password fields, a login button, and social login buttons (Google, Phone).
    - Create `RegisterScreen` with full name, email, phone, password, confirm password, and a register button.
    - Ensure field validation (e.g., email format, password match) and error handling are present.
  </action>
  <verify>flutter analyze lib/features/auth/screens/</verify>
  <done>Login and Register UI implemented with form validation.</done>
</task>

<task type="auto">
  <name>Integrate Firebase Auth (BLoC)</name>
  <files>pubspec.yaml, lib/data/services/firebase_auth_service.dart, lib/features/auth/bloc/auth_bloc.dart</files>
  <action>
    - Add `firebase_auth`, `google_sign_in`, `flutter_bloc`, and `equatable` to `pubspec.yaml`.
    - Create `FirebaseAuthService` to handle `signInWithEmailAndPassword`, `createUserWithEmailAndPassword`, and `signInWithGoogle`.
    - Create `AuthBloc` with states (Initial, Loading, Authenticated, Unauthenticated, Error) and events (LoginRequested, RegisterRequested, GoogleSignInRequested, LogoutRequested).
    - Provide `AuthBloc` at the root of the app in `main.dart`.
  </action>
  <verify>flutter pub get && flutter analyze</verify>
  <done>Authentication data layer and BLoC logic integrated.</done>
</task>

## Success Criteria
- [ ] Login screen validates inputs.
- [ ] Register screen validates inputs.
- [ ] Firebase Auth integration provides working logic for email/google sign in.
