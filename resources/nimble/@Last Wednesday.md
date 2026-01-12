---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2026-01-07
---

# @Last Wednesday

Hi Feedfast Team,Thanks for sharing the Phase 1 requirements for Feedfast. To help us propose an accurate scope, architecture, team structure, and estimate, I’d like to clarify a few points. I’ll keep this focused on the items that will most affect scope, timeline, and cost. **Please answer what you can — rough ranges/assumptions are totally fine.**

**1. Platforms in Phase 1**

Which customer experiences are in scope for Phase 1: responsive **web** ordering, native **iOS**, native **Android** (or some combination)?

- Is **“apps”** a hard requirement for Phase 1, or acceptable as Phase 2?

**2. Stores and rollout**How many restaurant locations are in scope for Phase 1?Do all locations share the same menu/pricing/hours, or are these location-specific?

- Which **market/country** is Phase 1 launching in (currency, language, tax invoice/receipt requirements)?

**3. Menu structure & inventory**

- Do menu items have modifiers/variants (e.g., size, add-ons, spice level), combos, or special instructions?
- Do you need “out of stock” / limited availability / time-based menus?
- Any dietary/allergen labeling requirements (e.g., allergens, nutrition)?

**4. Delivery model**

- For delivery orders: is delivery fulfilled by Feedfast (own drivers) or a third-party logistics provider?
- How should delivery fees and delivery radius be determined (flat fee, distance-based, by zone)?

**5. Ordering operations & POS**What POS system/vendor is used in-store today? Does it provide APIs/webhooks or existing integration options?

- For Phase 1, is the expectation (a) **full POS integration**, or (b) **a lightweight store order** console that staff can operate, with reconciliation handled later?

**Staff user stories:** What actions should store staff be able to perform on online orders in Phase 1 (e.g., accept/reject, update status like preparing/ready/collected, and send the order to the kitchen via **POS kitchen printer tickets or a kitchen display screen (KDS)**; handle substitutions/out-of-stock; manager overrides)?

- What system/process does finance use for accounting today, and what **reconciliation output** is needed (daily summary, per-store breakdown, exports)?

**6. Order lifecycle**

- Do you require scheduled orders/time slots (pickup/delivery), or only ASAP ordering?
- What are the requirements for cancellation, refunds, partial refunds, and order status updates?
- **Notifications:** Do you need order updates via **email/SMS/push** notifications in Phase 1 (order confirmed, ready, out for delivery), and do you already have an SMS provider?

**7. Payments (Stripe)**

- Confirm whether you want to support saved payment methods, and whether 3DS/SCA is required for your market.
- Any constraints around settlement timing or chargeback/dispute handling that we should account for?

**8. Fraud & promo abuse**

- What are the main fraud patterns you see today (stolen cards, chargebacks, voucher abuse, fake accounts)?
- Any current thresholds/controls you already use or want (e.g., velocity limits, manual review, device-based checks)?

**9. Loyalty & vouchers (Voucherify)**

- What loyalty model should Phase 1 support (e.g., points per spend, tiers, vouchers only, both)?
- Do you need to migrate any existing loyalty data/customers into Voucherify?

**10. Marketing attribution & deep linking**

- Which channels are most important to attribute (e.g., Meta, Google, LINE, TikTok, email), and what level of attribution is needed (channel vs campaign/adset/creative)?
- For “land directly on a product page”: does this need to work across web and native apps on day 1?

**Optional (for sizing assumptions):** if you can share rough ranges, what are the expected monthly orders and peak-hour order volume for Phase 1 (launch) and at ~6 months?Thanks in advance — these answers should let us finalize a clear one-page discovery & solutioning summary with realistic scope, risks, and estimates.