# SPEC.md — Project Specification

> **Status**: `FINALIZED`

## Vision
A premium Flutter mobile application for **Shree Bhidbhanjan Hanuman Temple** that serves as a spiritual companion for devotees worldwide. The app provides a seamless interface for digital darshan, real-time aarti tracking, event participation, and sacred contributions, bridging the gap between ancient traditions and modern mobile technology.

## Goals
1. **Digital Connection**: Provide a 24/7 spiritual link to the temple via real-time timings, gallery, and live updates.
2. **Operational Clarity**: Ensure devotees have accurate, up-to-date schedule information for aartis and festivals.
3. **Streamlined Service**: Facilitate online donations and event registrations through a secure, intuitive mobile interface.
4. **Community Engagement**: Keep the "Bhidbhanjan" community informed through a blog and announcement system.

## Non-Goals (Out of Scope)
- Full e-commerce system for physical prasad delivery (Digital donation/seva only for V1).
- Live 24/7 video streaming (Future phase - V1 focuses on static/recorded gallery).
- Multi-temple support (Dedicated solely to Shree Bhidbhanjan Hanuman Temple).

## Users
- **Devotees (Local)**: Users who visit the temple physically and need quick access to current timings and facilities.
- **Devotees (Global)**: Far-away users who participate through digital darshan, blogs, and online donations.
- **Temple Administrators**: Users who update timings, post announcements, and manage event photo galleries.

## Constraints
- **Technical**: Must use Flutter 3.0+ and Firebase (Auth, Firestore, Storage, Cloud Messaging).
- **Linguistic**: Full support for both English and Gujarati (and Hindi as secondary).
- **Accessibility**: Design must be legible for older devotees (large text options, high contrast).
- **Connectivity**: Basic features (timings, cached blog) must work offline.

## Success Criteria
- [ ] Comprehensive implementation of all 24 specified screens.
- [ ] Functional Firebase integration for user authentication and real-time updates.
- [ ] Successful "Add to Calendar" and Notification reminder system for Aartis.
- [ ] Intuitive navigation between 7 core sections (Home, Timings, Events, Gallery, Blog, Info, Donation).
- [ ] High-performance image loading and caching for the Gallery section.
