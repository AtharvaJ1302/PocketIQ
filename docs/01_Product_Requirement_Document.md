# Product Requirement Document (PRD)

| Field | Details |
|--------|---------|
| Project Name | PocketIQ |
| Version | v1.0.0 |
| Document Version | 1.0 |
| Status | Draft |
| Author | Atharva Joshi |
| Development Approach | Iterative Product Development |
| Technology Stack | Flutter, Firebase, Riverpod |
| Last Updated | 01 July 2026 |

---

# 1. Product Overview

## Introduction

PocketIQ is a modern personal finance management application designed to simplify how users monitor, understand, and control their spending.

Unlike traditional expense trackers that require users to manually record every transaction, PocketIQ aims to reduce manual effort by intelligently detecting financial transactions through SMS parsing and notification listeners, while allowing users to enrich those transactions with meaningful descriptions and categories.

The application provides a unified dashboard for managing multiple bank accounts, credit cards, budgets, analytics, and spending insights within a visually appealing and intuitive user experience tailored for modern users.

PocketIQ focuses on making financial awareness engaging rather than overwhelming by combining automation, clean design, and meaningful data visualization.

---

# 2. Vision Statement

To build a modern, intelligent, and visually engaging personal finance application that empowers users to understand their financial habits, make better spending decisions, and manage multiple financial accounts effortlessly through automation, insightful analytics, and a premium user experience.

---

# 3. Problem Statement

Managing personal finances today often requires users to switch between multiple banking applications, UPI platforms, and spreadsheets to understand where their money is being spent.

Most expense tracking applications depend heavily on manual data entry, resulting in poor long-term user engagement and incomplete financial records.

Users frequently lose track of:
- Spending across multiple bank accounts.
- Credit card utilization.
- Monthly budgets.
- Category-wise expenses.
- Recurring spending patterns.

Furthermore, many existing finance applications prioritize functionality over user experience, making budgeting feel like a chore rather than a helpful daily habit.

PocketIQ aims to solve these challenges by introducing an automated, intuitive, and engaging financial management experience.

---

# 4. Product Goals

PocketIQ is being developed with the following primary goals:

### Primary Goals

- Provide a centralized dashboard for managing multiple bank accounts and credit cards.
- Minimize manual expense entry through intelligent transaction detection.
- Help users develop better spending habits using modern analytics and budgeting tools.
- Deliver a premium user experience with smooth animations and intuitive navigation.
- Build an application that is scalable, secure, and production-ready.

### Secondary Goals

- Demonstrate industry-standard Flutter architecture.
- Serve as a flagship portfolio project.
- Document the complete software engineering journey through AI-assisted development.
- Build a foundation for intelligent financial insights.

---

# 5. Target Audience

PocketIQ is designed for individuals who want a modern, intuitive, and intelligent way to manage their personal finances without the complexity of traditional budgeting applications.

### Primary Audience

- College students managing monthly allowances.
- Young professionals tracking salary and daily expenses.
- Individuals using multiple bank accounts.
- Users managing both debit accounts and credit cards.
- UPI users who make frequent digital payments.

### Secondary Audience

- Freelancers managing personal income and expenses.
- Small business owners tracking day-to-day spending.
- Users who want better financial awareness without maintaining spreadsheets.

---

# 6. User Personas

## Persona 1 – The Young Professional

**Name:** Aarav

**Age:** 25

**Occupation:** Software Engineer

**Goals**

- Track monthly expenses.
- Stay within budget.
- Manage multiple salary accounts.
- Reduce unnecessary spending.

**Pain Points**

- Uses multiple banking apps.
- Frequently forgets small expenses.
- Doesn't know where money goes each month.

PocketIQ Solution

- Unified dashboard.
- Automatic transaction detection.
- Spending insights.
- Budget alerts.

---

## Persona 2 – The College Student

**Name:** Riya

**Age:** 21

**Occupation:** Student

**Goals**

- Track allowance.
- Avoid overspending.
- Save money every month.

**Pain Points**

- Small expenses accumulate quickly.
- Rarely keeps records.
- Doesn't understand spending patterns.

PocketIQ Solution

- Category-wise analytics.
- Budget tracking.
- Weekly spending reports.
- Visual spending summaries.

---

## Persona 3 – The Credit Card User

**Name:** Rahul

**Age:** 30

**Occupation:** Marketing Manager

**Goals**

- Monitor available credit.
- Avoid overspending.
- Keep track of credit card usage.

**Pain Points**

- Uses multiple credit cards.
- Loses track of available limits.
- Difficulty comparing spending across cards.

PocketIQ Solution

- Swipeable account cards.
- Credit utilization tracking.
- Spending alerts.
- Unified dashboard.

---

# 7. Success Metrics

The success of PocketIQ Version 1.0 will be measured using the following indicators.

### User Experience

- Fast and intuitive navigation.
- Smooth animations throughout the application.
- Minimal learning curve for first-time users.

### Performance

- Application startup time under 3 seconds.
- Dashboard loads within 1 second after authentication.
- Smooth scrolling and animations at 60 FPS on supported devices.

### Reliability

- Stable authentication flow.
- Accurate SMS and notification parsing.
- Offline data availability for previously synced information.

### Product Goals

- Support multiple bank accounts.
- Support multiple credit cards.
- Automatic expense detection.
- Intelligent budgeting.
- Interactive analytics dashboard.

---

# 8. Minimum Viable Product (MVP)

Version 1.0 of PocketIQ will include the following features.

## Authentication

- Mobile number authentication.
- OTP verification.
- Secure PIN setup.
- Fingerprint authentication.
- Face ID authentication (supported devices).

## Dashboard

- Swipeable account cards.
- Recent transactions.
- Budget overview.
- Money timeline.
- Quick statistics.

## Accounts

- Add bank account.
- Add credit card.
- Switch between accounts.
- View account details.

## Expense Management

- SMS transaction detection.
- Notification listener support.
- Manual description editing.
- Category assignment.
- Expense history.

## Budget

- Monthly budget.
- Category budgets.
- Budget alerts.
- Remaining balance indicator.

## Analytics

- Category spending chart.
- Weekly spending.
- Monthly spending.
- Interactive insights.

## Statements

- Monthly PDF statement.
- CSV export.
- Transaction history.

---

# 9. Out of Scope (Version 1)

The following features are intentionally excluded from Version 1.0.

- Direct bank API integration.
- UPI payment functionality.
- Investment tracking.
- Mutual funds.
- Stock portfolio management.
- Loan management.
- Family expense sharing.
- Cloud synchronization across multiple devices.
- AI chatbot.
- Voice assistant.
- Web application.

These features may be considered in future releases.

---

# 10. Functional Requirements

The following functional requirements define the core capabilities of PocketIQ Version 1.0.

---

## Authentication Module

### FR-001 — User Registration

**Description**

The system shall allow a new user to register using a valid mobile number.

**Priority**

High

---

### FR-002 — OTP Verification

**Description**

The system shall verify the user's identity through One-Time Password (OTP) authentication.

**Priority**

High

---

### FR-003 — Secure Login

**Description**

The system shall securely authenticate returning users.

**Priority**

High

---

### FR-004 — Biometric Authentication

**Description**

The system shall support fingerprint and facial recognition authentication on supported devices.

**Priority**

High

---

## Dashboard Module

### FR-005 — Account Dashboard

The system shall display a dashboard containing financial information related to the currently selected account.

Priority: High

---

### FR-006 — Swipeable Account Cards

Users shall be able to switch between accounts using swipeable cards.

Priority: High

---

### FR-007 — Recent Transactions

The dashboard shall display the latest four transactions for the selected account.

Priority: High

---

### FR-008 — View All Transactions

Users shall be able to navigate to the complete transaction history.

Priority: High

---

## Account Management

### FR-009 — Add Bank Account

Users shall be able to add multiple bank accounts.

Priority: High

---

### FR-010 — Add Credit Card

Users shall be able to add multiple credit cards.

Priority: High

---

### FR-011 — Switch Accounts

Users shall be able to switch between linked accounts.

Priority: High

---

## Expense Tracking

### FR-012 — SMS Detection

The system shall detect eligible financial transactions from SMS messages after receiving the necessary permissions.

Priority: High

---

### FR-013 — Notification Detection

The system shall detect eligible financial transactions through Android notification access after user consent.

Priority: High

---

### FR-014 — Manual Expense Details

Users shall be able to assign descriptions and categories to automatically detected transactions.

Priority: High

---

### FR-015 — Expense Categories

The system shall categorize expenses into predefined categories and allow users to edit them.

Priority: High

---

## Budget Module

### FR-016 — Monthly Budget

Users shall be able to define an overall monthly spending budget.

Priority: High

---

### FR-017 — Category Budgets

Users shall be able to define spending limits for individual categories.

Priority: Medium

---

### FR-018 — Budget Alerts

The system shall notify users when spending reaches configurable thresholds.

Priority: High

---

## Analytics

### FR-019 — Spending Analytics

The system shall provide graphical visualization of user spending.

Priority: High

---

### FR-020 — Weekly Analytics

The system shall display weekly spending summaries.

Priority: Medium

---

### FR-021 — Monthly Analytics

The system shall display monthly spending summaries.

Priority: High

---

### FR-022 — Spending Insights

The system shall generate intelligent spending summaries using available transaction data.

Priority: Medium

---

## Statements

### FR-023 — PDF Statement

Users shall be be able to generate monthly PDF statements.

Priority: Medium

---

### FR-024 — CSV Export

Users shall be able to export transaction history in CSV format.

Priority: Low

---

## Settings

### FR-025 — Theme Settings

Users shall be able to switch between light and dark mode.

Priority: Low

---

### FR-026 — Security Settings

Users shall be able to manage PIN and biometric authentication preferences.

Priority: High

---