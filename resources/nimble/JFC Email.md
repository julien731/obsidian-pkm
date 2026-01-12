---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2024-11-16
---

# JFC Email

Hi, Kevin, Dan, Grant, and team.

I understand that there are frustrations on your end due to the lack of visibility on the plan and the recent delays on the features we are currently testing.

We also understand the importance of getting the right data early on and we appreciate the work that Jollibee and the Data Team are putting into leveraging data to support and advance the business.

I want to assure everyone that we are treating this project with the utmost importance and a deep sense of urgency. Our commitment to the success of Apollo focused in delivering several features that address gaps such as cookies management and consent management (currently built on the back of Okya).

I also want to assure you that both Nimble and Okya have the necessary expertise to deliver on all the Jollibee requirements on all fronts.

We have customized several features (native mobile signup, order number) and even we got ahead on the needs that were raised before contract signing (e.g. restaurant delivery zone which was later dropped).

To provide visibility, we have parallel streams of work to cover all the needs from Jollibee Group and we are fully committed on our mutual success. The launch of CBTL and hyper care support we provided over the weekends changed our release cadence but did not stop the features development at all.

To address the question about the pending features:

- Menu sync: is already deployed on staging.
- SC/PWD: is already deployed to staging.
- Data export: the only challenges here are on non-functional requirements as we are legally bound by PDPA and we must be sure the PII data is transferred appropriately and with the right controls in place (PIA, DPIA, Privacy by design checklist, Record of processing activities, etc.). We are treating PII very seriously. We don’t want to repeat incidents that happened with other vendors like Snowflake or Paytronix. 
Technically the functionality to pull/export data will be already available on staging via our report engine on the next release (Monday).
- User migration: the user import functionality will be on staging in the next release (Monday). We will operationalize the reactivation of the users post-import using passwordless from Okya Auth which was also recently delivered.

None of the features represent a technical challenge for us. The challenges are on non-functional requirements, e.g. frequency, PII treatment, server load and throttling, SOC2 compliance and timeline.

Your success is our success. We are fully committed to delivering Apollo and make it a great positive impact for Jollibee.

Let’s discuss on Monday to close the open topics.

Thanks

Carlos

Regarding the data transfer more specifically, as time-to-deliver is of the essence, we will push gzipped CSV reports to an S3 bucket on a daily basis for your consumption. This way, you will be able to start ingesting the data starting from INSERT DATE.

Please note that this will require a liability waiver. As we are contractually bound to protecting the Jollibee data, we will need to waive our liability at the moment the data leaves our hands.

This brings us to a non-functional topic that we need to discuss: how to handle PII when we transfer data over. It is important that we have a clear plan for this, especially in light of the recent data breaches that occurred via Snowflake and Paytronix in the US where customer PII was leaked.