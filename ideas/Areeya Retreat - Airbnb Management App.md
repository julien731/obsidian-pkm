---
type: idea
status: active
created: 2026-02-18
category: side-project
summary: Small app to manage Areeya Retreat property, connecting to the Airbnb API
tags:
  - airbnb
  - property-management
  - side-project
  - replit
---

# Areeya Retreat — Airbnb Management App

## Context

- **Property**: 3BR pool villa in Pran Buri, Thailand ([areeyaretreat.com](https://areeyaretreat.com/), [Airbnb listing](https://www.airbnb.com/rooms/606275521831337204))
- **Rating**: 4.95/5 (37 reviews as of Feb 2026)
- **Operations**: Managed remotely by Julien + wife, local housekeeper on-site
- **Current platform**: Airbnb only, goal to grow off-platform/direct bookings
- **Core pain**: No reliable tracking of bookings, revenue, expenses, or occupancy

## Stack

- **Framework**: SvelteKit (full-stack, lightweight, reactive UI for calendar/dashboard)
- **Database + Auth + Storage**: Supabase free tier (Postgres 500MB, Auth, 1GB file storage for receipts)
- **Hosting**: Vercel free tier (no cold starts, serverless functions)
- **iCal sync**: Vercel Cron Jobs (free, daily sync from Airbnb iCal feed)
- **Payout reminders**: Supabase Edge Functions + Resend (free tier: 100 emails/day)
- **Charts**: Chart.js or Frappe Charts
- **Estimated ongoing cost**: $0

## Features

### Phase 1 — Know Your Numbers (MVP)

The foundation. Solves the immediate pain of not having visibility into the business.

**Booking tracker**
- Import bookings from Airbnb (iCal sync for dates + guest name)
- Calendar view showing occupancy at a glance
- Status tracking: upcoming / in-progress / completed / cancelled

**Revenue tracking** (manual input, made simple)
- When a booking is synced from iCal, prompt to fill in: nightly rate, number of nights, Airbnb fees, expected payout
- Quick-entry form — as few fields as possible, sensible defaults (e.g., pre-fill nightly rate from last booking)
- **Payout reconciliation reminders**: after checkout, flag the booking as "payout expected" → remind until marked as received
- Mark payout as received with actual amount (catch discrepancies vs. expected)
- Highlight overdue payouts (e.g., Airbnb typically pays ~24h after check-in)

**Financial dashboard**
- Monthly and yearly revenue (gross vs. net after Airbnb fees)
- Occupancy rate: nights booked vs. available, by month
- Average nightly rate (ADR) and revenue per available night (RevPAN)
- Simple chart/trend showing month-over-month performance
- Outstanding payouts: total amount expected but not yet received

**Expense tracking**
- Log expenses by category: cleaning, maintenance, supplies, utilities, platform fees, etc.
- Attach receipts (photo upload)
- Monthly P&L view: revenue minus expenses = actual profit
- Flag recurring expenses (e.g., monthly pool maintenance)

### Phase 2 — Grow Direct Bookings

Reduce Airbnb dependency and increase margins.

**Direct booking page**
- Simple availability calendar on areeyaretreat.com (reads from the app)
- Inquiry/booking request form (not full payment processing yet — start with inquiry → manual confirmation)
- Integrate a payment link (Stripe or similar) once volume justifies it

**Multi-channel calendar**
- Single calendar syncing across Airbnb + direct bookings
- Prevent double-bookings
- Tag bookings by source (Airbnb, direct, referral)

**Basic CRM**
- Past guest list with stay history
- Tag guests (repeat, VIP, left review, etc.)
- Enable re-marketing: "Hey, you stayed with us last year — here's 10% off for a direct booking"

### Phase 3 — Operations & Automation

Polish and efficiency gains once the core is solid.

**Guest management**
- Check-in instructions template (auto-sent or ready to copy-paste)
- Guest notes (preferences, issues, special requests)
- Automated messaging: check-in reminders, review requests

**Housekeeper coordination**
- Simple shared view for upcoming turnovers
- Cleaning checklist per turnover
- Notifications on new bookings

### Later / Nice-to-Have
- Dynamic pricing suggestions based on occupancy and season
- Booking.com / Agoda integration if multi-platform becomes relevant
- Tax reporting (Thai tax obligations for rental income)
- Comparative analytics (vs. similar listings in Pran Buri)

## Open Questions
- **Expense input UX**: Should be dead simple since this needs to become a habit. Mobile-friendly form, maybe LINE integration for the housekeeper to report expenses?
- **Reminder delivery**: How to send payout reconciliation reminders? Push notification, email, LINE?
- **Housekeeper language**: Does the housekeeper interface need to be in Thai?
- **Direct booking payments**: At what volume does it make sense to add Stripe? Start with inquiry-only and manual bank transfer?
