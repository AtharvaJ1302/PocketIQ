# PocketIQ - Project Development Log

This document tracks the development journey of PocketIQ from idea to production.

---

# Day 1 - 30 June 2026

## Objective
Project planning and product definition.

### Completed
- Finalized PocketIQ app idea
- Defined core features
- Created GitHub repository
- Created project documentation structure
- Wrote README
- Created architecture documentation
- Defined product roadmap
- Defined database planning
- Defined API planning
- Planned UI/UX direction
- Finalized brand identity
- Finalized application flow
- Designed Home Dashboard concept
- Designed Account Card concept
- Finalized design language
- Locked technology stack
- Decided on feature-first architecture

### Outcome
PocketIQ planning phase completed. Ready to begin Flutter development.

---

# Day 2 - 01 July 2026

## Completed

- Finalized project architecture
- Completed Splash Screen
- Completed Onboarding flow
- Built reusable design system
- Added AppSpacing, AppRadius and AppDuration
- Created PocketButton
- Created PocketTextField
- Created PocketPasswordField
- Created AppLogo
- Added authentication module structure
- Built AuthHeader and AuthFooter
- Started Login Screen
- Fixed dark theme typography issues

## Decisions

- Locked project architecture
- Locked design system
- Shared components live under shared/components
- Feature-specific widgets remain inside their feature
- No further restructuring unless required

# Day 3 - 02 July 2026

## Completed

### Login Screen
- Improved keyboard navigation using `FocusNode`.
- Added field-to-field focus traversal.
- Dismiss keyboard on outside tap.
- Submit login using keyboard action.
- Fixed dark mode text visibility.
- Improved validation flow.

### Registration Screen
- Fixed dark mode text colors.
- Improved validation consistency.
- Enhanced text field behavior.

### Forgot Password
- Connected with Login screen.
- Prepared for Firebase Authentication integration.

# ✅ Authentication Module

### Login Screen
- Improved keyboard navigation using `FocusNode`.
- Added field-to-field focus traversal.
- Dismiss keyboard on outside tap.
- Submit login using keyboard action.
- Fixed dark mode text visibility.
- Improved validation flow.

### Registration Screen
- Fixed dark mode text colors.
- Improved validation consistency.
- Enhanced text field behavior.

### Forgot Password
- Connected with Login screen.
- Prepared for Firebase Authentication integration.

---

# ✅ Dashboard

### Balance Card
- Refined layout and spacing.
- Improved typography hierarchy.
- Prepared balance visibility state.
- Improved card styling.

### Actions Section
- Renamed **Quick Actions** → **Actions**.
- Improved semantic colors.
- Better spacing.
- Fixed dark mode styling.

### Home App Bar
- Wrapped notification button for consistency.
- Improved overall UI alignment.

---

# ✅ My Accounts Section

Implemented a new dashboard section displaying user accounts.

### Features
- Horizontal scrolling cards.
- "View All" navigation.
- Compact account card design.
- Improved spacing.
- Account identification using:

```
Savings ••••4821
```

instead of displaying the account number on a separate line.

Prepared for:
- Account Details
- Edit Account
- Delete Account
- Bank emblems/icons

---

# ✅ Accounts Module

Implemented:

- Account Model
- Repository Pattern
- Repository Implementation
- Riverpod Provider
- Account Notifier

---

# ✅ Navigation

Connected application flow.

- Splash -> Onboarding -> Login/Register/Forgot Password -> Dashboard -> Accounts
