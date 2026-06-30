# Information Architecture

| Field   | Details  |
| ------- | -------- |
| Project | PocketIQ |
| Version | v1.0.0   |
| Status  | Draft    |

---

# Application Structure

PocketIQ is organized into five primary navigation areas.

## 1. Home

Purpose

Provide an instant overview of the user's financial status.

Contains

* Swipeable Account Cards
* Today's Spending
* Monthly Spending
* Budget Overview
* Money Timeline
* Recent Transactions
* Quick Actions

---

## 2. Transactions

Purpose

View and manage complete transaction history.

Contains

* Search
* Filters
* Categories
* Merchant Details
* Edit Description
* Edit Category
* Transaction Details

---

## 3. Analytics

Purpose

Help users understand spending habits.

Contains

* Spending Wheel
* Weekly Analytics
* Monthly Analytics
* Category Analysis
* Smart Insights
* Spending Trends

---

## 4. Budget

Purpose

Help users manage monthly spending.

Contains

* Monthly Budget
* Category Budgets
* Budget Rings
* Alerts
* Spending Progress

---

## 5. Profile

Purpose

Manage user preferences.

Contains

* Linked Accounts
* Security
* Notifications
* Theme
* Statements
* About
* Logout

---

# Secondary Screens

Authentication

* Splash
* Onboarding
* Login
* OTP
* PIN Setup
* Biometric Setup

Accounts

* All Accounts
* Add Account
* Account Details

Expense

* Expense Review
* Category Selection

Statements

* Statement Preview
* PDF Export
* CSV Export

Settings

* Theme
* Security
* Notification Settings

---

# Navigation Model

Splash

↓

Authentication

↓

Dashboard (Home)

↓

Bottom Navigation

* Home
* Transactions
* Analytics
* Budget
* Profile

---

# Floating Action Button

Visible only on Home.

Purpose

Quick Add

Future versions may expand this into a speed dial.

---

# Global Search

Accessible from Transactions.

Future enhancement:

Search across:

* Merchant
* Description
* Category
* Amount

---

# Navigation Principles

* Maximum three taps to any major feature.
* Avoid deep navigation stacks.
* Preserve navigation state between tabs.
* Use bottom sheets for lightweight tasks.
* Use full-screen pages for complex flows.

---

# Future Expansion

Reserved navigation space for:

* AI Assistant
* Goals
* Investments
* Family Accounts
* Rewards
