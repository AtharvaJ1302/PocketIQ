# Navigation Flow

| Field   | Details  |
| ------- | -------- |
| Project | PocketIQ |
| Version | v1.0.0   |
| Status  | Draft    |

---

# Navigation Philosophy

PocketIQ is designed to minimize friction.

Users should be able to reach any major feature within three taps while maintaining awareness of where they are inside the application.

Navigation should feel natural, predictable, and fluid.

---

# Application Entry

```
Launch App
      │
      ▼
Splash Screen
      │
      ▼
Is User Logged In?
      │
 ┌────┴────┐
 │         │
No        Yes
 │         │
 ▼         ▼
Onboarding Biometric Authentication
 │         │
 ▼         ▼
Login      Home Dashboard
 │
 ▼
OTP Verification
 │
 ▼
PIN Setup
 │
 ▼
Enable Biometrics
 │
 ▼
Grant Permissions
 │
 ▼
Add First Account
 │
 ▼
Home Dashboard
```

---

# Bottom Navigation

PocketIQ uses five primary destinations.

```
🏠 Home

💸 Transactions

📊 Analytics

🎯 Budget

👤 Profile
```

The selected tab should always preserve its state when switching.

---

# Home Navigation

```
Home Dashboard
      │
      ├── Swipe Account Cards
      │
      ├── View All Accounts
      │        │
      │        ├── Select Account
      │        └── Add Account
      │
      ├── Recent Transactions
      │        │
      │        └── View All Transactions
      │
      ├── Budget Overview
      │        │
      │        └── Budget Screen
      │
      ├── Analytics Preview
      │        │
      │        └── Analytics Screen
      │
      └── Floating Action Button
               │
               └── Add Account (Version 1)
```

---

# Transaction Flow

```
Transactions

│

├── Search

├── Filter

├── Transaction Details

│      ├── Edit Description

│      └── Edit Category

└── Statement Preview
```

---

# Automatic Expense Flow

```
Payment Completed

↓

SMS / Notification Detected

↓

Transaction Identified

↓

Smart Notification

↓

Review Transaction

↓

Add Description

↓

Select Category

↓

Save

↓

Dashboard Updated
```

---

# Budget Flow

```
Budget

│

├── Monthly Budget

├── Category Budgets

├── Budget History

└── Budget Alerts
```

---

# Analytics Flow

```
Analytics

│

├── Weekly

├── Monthly

├── Categories

├── Spending Trends

└── Smart Insights
```

---

# Profile Flow

```
Profile

│

├── Linked Accounts

├── Statements

├── Security

├── Notifications

├── Theme

├── About

└── Logout
```

---

# Navigation Rules

* Bottom navigation is the primary navigation method after login.
* Users should never lose the selected account while navigating.
* Navigation state should be preserved across tabs.
* Bottom sheets should be used for quick tasks.
* Full-screen pages should be reserved for complex workflows.
* Confirmation dialogs should appear before destructive actions.

---

# Future Navigation

The architecture intentionally leaves room for future additions without redesigning the application.

Potential future destinations include:

* AI Financial Assistant
* Savings Goals
* Investments
* Family Accounts
* Rewards & Achievements
* Subscription Manager
