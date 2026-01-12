---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2024-07-03
---

# Jollibee App Catch-Up

# Notes

- Search results UI different between iOS and Android
- Some analytics events done on Android but missing on iOS?
- Check the UX for saving default payment method and prepare backlog
- Consent management
- Maya Wallet → where does this come from??
- Incorrect tax on order details screen?? How sould we get the tax calculation?

# Missing

- Promotions (blocked)
- Changing address with items in the cart: missing logic for asking user whether they want to stay on the same store
- Show current location on the address field, delivery details screen, for logged out users
- Linked accounts (Google, Facebook, etc)
- Guest users
- Payment details on order tracking screen and order details screen
- https://nimble-co.slack.com/archives/C05PYU3HB51/p1720153186029729?thread_ts=1719980334.826869&cid=C05PYU3HB51
- [JB’s unfulfilled features](https://www.notion.so/JB-s-unfulfilled-features-4a700f9fcd0547beb4a25602fd1fa142?pvs=21)

# Review

- [x]  Make sure we have a task for showing the proper payment method on order detail screen. Requires CX talk.
- [x]  Edit quantity of an in-cart item
    - Deprioritized on mobile
    - Probably deprioritize on web, too
- [x]  Need a loading spinner when you place an order. There is no visual feedback.
- [ ]  Why is the PayMaya UI different between iOS and Android?

# Questions

- When adding an SC/PWD card to an order, are we already sending the ID to the backend alongside the order?
- Are we automatically reverting a payment if the order fails?