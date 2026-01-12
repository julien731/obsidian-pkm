---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2024-11-19
---

# CBTL Resources Email

Hi, everyone.

Following yesterday’s discussion about the Mulesoft infrastructure we realized the cost associated with it. I understand that it is a showstopper.

Kevin shared with us the cost per vCore. Now that we have visibility on it, we can factor it into our decisions regarding infrastructure needs.

We held an internal meeting yesterday evening with all the Team Leads and Product Managers for all the JFC projects using the JBridge ecosystem (CBTL, Global Templates, Jollibee) to assess how we can optimize performance without increasing infrastructure.

We can achieve this via a few different initiatives. TLDR; **I want to confirm that we can continue with the Nov. 21st release.**

What we will do next is:

- Deploy the memory optimizations already completed to production as a first step to support higher load. This doesn’t require an app update.
- Improve how we first load the store menu on the apps. The first user that warms up the cache has a relatively longer request time as the app is requesting a very large payload. After that, further requests are fast for everyone. Still, on middleware, stats it shows this first request as a slow request. We will improve on the app UX, leveraging the skeleton loading instead of loading the full menu.
- As a consequence of the skeleton loading, we will update the middleware and cache smaller payloads.
- Finally, we are wrapping up an assessment on modifying the timeout on the middleware which could result in the following (no app update required).
    - Less time for customers waiting in case an upstream service times out.
    - A faster decongestion of the infrastructure as the requests queue will clear faster in case of an upstream timeout.

With all of the above progressively added, we feel confident for the Nov. 21st launch without a preliminary increase in resources for Mulesoft.

In conclusion, I can update our recommendation to keeping the current infrastructure and continuing to monitor the APIs response times.

Best,
Julien