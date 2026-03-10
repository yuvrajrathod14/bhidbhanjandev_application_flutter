# RESEARCH.md

## Technical Stack Recommendations

### 1. State Management: BLoC (Business Logic Component)
**Rationale**: The requirement specifically mentions "Clean architecture". BLoC provides the most rigid separation between UI and the business logic/events, making it ideal for a 20+ screen application with multiple states (Loading, Shimmer, Empty, Error).
- **Alternative**: Riverpod (more concise, but less "strict" on side effects).

### 2. Folder Structure: Feature-First
**Rationale**: With 7 distinct sections (Home, Timings, Events, etc.), a feature-first structure is much easier to maintain than a layer-first one.
```
lib/
├── features/
│   ├── auth/
│   ├── home/
│   ├── timings/
│   ├── events/
│   └── gallery/
├── core/
│   ├── theme/
│   ├── constants/
│   └── utils/
└── data/
    ├── services/ (Firebase)
    └── models/
```

### 3. Payment Gateway: Razorpay
**Rationale**: Standard in India for UPI and card payments. Supports Flutter natively and handles GST/80G details well.

### 4. Localization: flutter_localizations & Intl
**Rationale**: Best-in-class support for English/Gujarati/Hindi.

## Research Decision Needed
> [!IMPORTANT]
> Do you approve of using **BLoC** for state management and a **Feature-First** architecture? If you prefer **Riverpod** or **GetX**, please let me know before we start Phase 1 execution.
