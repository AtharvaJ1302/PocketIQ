# User Journey

| Field   | Details  |
| ------- | -------- |
| Project | PocketIQ |
| Version | v1.0.0   |
| Status  | Draft    |

---

# 1. First-Time User Journey

### Goal

Help a new user reach the dashboard quickly while setting up a secure and personalized experience.

## Flow

Launch App

↓

Animated Splash Screen

↓

Onboarding (3 screens)

↓

Sign Up / Login

↓

OTP Verification

↓

Create PIN

↓

Enable Fingerprint / Face ID

↓

Grant SMS Permission (Optional)

↓

Grant Notification Access (Optional)

↓

Add First Bank Account

↓

Home Dashboard

---

Expected Completion Time

Less than 5 minutes.

---

# 2. Returning User Journey

Launch App

↓

Biometric Authentication

↓

Home Dashboard

↓

Continue using the application

No OTP or login should be required unless the session expires or the user logs out.

---

# 3. Home Dashboard Journey

The dashboard acts as the central hub.

Users should immediately see:

* Selected account
* Current balance
* Today's spending
* Monthly spending
* Remaining budget
* Latest transactions
* Quick actions

Users can:

* Swipe between accounts.
* Open analytics.
* View all transactions.
* Add a new account.
* View statements.

---

# 4. Account Management Journey

Home

↓

All Accounts

↓

Select Account

or

↓

Add Account

↓

Enter Details

↓

Account Added

↓

Dashboard Updates Automatically

---

# 5. Automatic Expense Detection Journey

User completes a payment.

↓

SMS or Notification detected.

↓

PocketIQ identifies a potential transaction.

↓

A smart notification appears.

"New expense detected"

↓

User taps notification.

↓

Bottom Sheet opens.

Already filled:

* Amount
* Date
* Payment Method
* Merchant (if detected)

User adds:

* Description
* Category

↓

Save

↓

Dashboard updates automatically.

---

If detection fails:

The transaction is ignored without interrupting the user.

---

# 6. Budget Journey

Dashboard

↓

Budget Screen

↓

Create Monthly Budget

↓

(Optional)

Create Category Budgets

↓

Track Progress

↓

Receive Alerts

↓

Monthly Summary

---

# 7. Analytics Journey

Dashboard

↓

Analytics

↓

View

* Weekly spending
* Monthly spending
* Categories
* Trends
* Insights

↓

Interact with charts

↓

Return to dashboard

---

# 8. Statement Journey

Dashboard

↓

Statements

↓

Choose Month

↓

Preview Statement

↓

Download PDF

or

Export CSV

---

# 9. Settings Journey

Dashboard

↓

Settings

↓

Manage

* Security
* Biometrics
* Theme
* Notifications
* Data Export

↓

Save

---

# 10. User Stories

## US-001

As a user,

I want to log in securely using biometrics,

so that I can access my financial data quickly.

---

## US-002

As a user,

I want PocketIQ to detect my expenses automatically,

so that I don't have to manually enter every transaction.

---

## US-003

As a user,

I want to switch between multiple accounts,

so that I can monitor each account separately.

---

## US-004

As a user,

I want visual analytics,

so that I can understand my spending habits.

---

## US-005

As a user,

I want budget alerts,

so that I don't exceed my planned spending.

---

## US-006

As a user,

I want downloadable statements,

so that I can review and share my financial records whenever needed.
