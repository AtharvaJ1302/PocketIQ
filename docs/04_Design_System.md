# PocketIQ Design System

| Field            | Details  |
| ---------------- | -------- |
| Project          | PocketIQ |
| Version          | v1.0.0   |
| Document Version | 1.0      |
| Status           | Draft    |

---

# 1. Design Vision

PocketIQ should feel like a premium fintech application built for modern users.

The interface should be:

* Minimal
* Premium
* Fast
* Clean
* Confident
* Intelligent
* Calm

The user should never feel overwhelmed by information.

Every screen should have a clear hierarchy and a single primary focus.

---

# 2. Design Inspiration

PocketIQ draws inspiration from products known for exceptional user experience.

### Visual Inspiration

* CRED
* Jupiter
* Apple Wallet
* Linear
* Notion
* Material 3

The goal is inspiration, not imitation.

PocketIQ should establish its own visual identity.

---

# 3. Color Philosophy

Colors should communicate meaning.

### Primary

Used for:

* Primary buttons
* Selected states
* Interactive elements

### Secondary

Used for:

* Supporting actions
* Chips
* Filters

### Success

Used for:

* Budgets within limits
* Successful actions

### Warning

Used for:

* Budget nearing limit
* Important reminders

### Error

Used for:

* Budget exceeded
* Failed actions
* Validation errors

### Neutral

Used for:

* Backgrounds
* Cards
* Borders
* Text hierarchy

---

# 4. Typography Principles

Typography should prioritize readability.

Hierarchy:

* Display
* Headline
* Title
* Body
* Label
* Caption

Numbers such as balances and budgets should receive visual priority over descriptive text.

---

# 5. Spacing System

Use consistent spacing throughout the application.

Base spacing unit:

8dp

Common spacing:

* 8dp
* 16dp
* 24dp
* 32dp
* 48dp

Consistency is more important than density.

---

# 6. Corner Radius

Small Components

12dp

Cards

20dp

Bottom Sheets

28dp

Dialogs

24dp

Floating Action Button

Circular

---

# 7. Elevation

Keep shadows subtle.

Cards should appear layered without feeling heavy.

Avoid excessive elevation.

---

# 8. Iconography

Icons should be simple and consistent.

Prefer rounded Material Symbols.

Each financial category should have an easily recognizable icon.

Examples:

Dining

Shopping

Fuel

Travel

Medical

Entertainment

Bills

Education

Salary

Investment (Future)

---

# 9. Components

PocketIQ will use reusable components.

Examples:

* Swipeable Account Card
* Budget Ring
* Transaction Card
* Analytics Card
* Insight Card
* Statistic Tile
* Category Chip
* Empty State
* Error State
* Skeleton Loader

Every screen should be built from reusable components.

---

# 10. Motion Design

Animations should feel responsive and intentional.

Recommended durations:

Fast

150ms

Normal

250ms

Complex

350ms

Animations should support understanding rather than distract from it.

---

# 11. Haptic Feedback

Provide subtle haptic feedback for:

* Successful login
* Account switching
* Saving an expense
* Completing onboarding
* Pull to refresh
* Important confirmations

Avoid excessive vibration.

---

# 12. Light & Dark Theme

Both themes should receive equal attention.

Dark mode should not simply invert colors.

Charts, cards, typography, and accent colors should remain readable and visually balanced.

---

# 13. Empty States

Every empty screen should guide the user.

Example:

"No transactions yet."

Rather than ending there, provide a clear action:

"Your detected transactions will appear here."

or

"Add your first account to get started."

---

# 14. Loading States

Avoid blank screens.

Use skeleton loaders where appropriate.

Show meaningful loading indicators for long-running operations.

---

# 15. Error Handling

Errors should always explain:

* What happened
* Why it happened (when possible)
* How the user can recover

Never expose technical error messages.

---

# 16. Accessibility

Ensure:

* Large touch targets
* High contrast
* Readable typography
* Support for dynamic text scaling
* Screen reader compatibility where applicable

Accessibility should be considered from the beginning rather than added later.

---

# 17. Design Principles Summary

Every screen in PocketIQ should satisfy these principles:

* Simple before complex.
* Motion with purpose.
* Data tells a story.
* Security without friction.
* Consistency above creativity.
* Premium without unnecessary decoration.
* Delight through thoughtful interactions.
