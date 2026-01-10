---
type: project
created: 2026-01-10
status: completed
tags:
  - email
migrated_from: notion
migrated_at: 2026-01-10
---

# Setup DMARC monitoring on domain

Resources: What the heck is BIMI and why is it so important? (../Second%20Brain/Resources/What%20the%20heck%20is%20BIMI%20and%20why%20is%20it%20so%20important%2014437367d0b3803590fcd41de84d4fef.md)

# Why

Describe the rationale for this project.

# Expected Outcome

Define what the project completion should achieve.

# Notes

One of the benefits of setting up DMARC is that reports are automatically sent regarding emails delivery. There is a daily aggregated report (the `rua` param in the DMARC record) and a forensics report send after each email failure (the `ruf` param in the DMARC record).

While it’s very cumbersome to manually review and process those reports, there are services that can monitor them. Some of those services are the following.

[Home - dmarcian](https://dmarcian.com/)

[DMARC Digests - Protect your brand from email scammers](https://dmarcdigests.com/)

[Best-in-Class DMARC Solutions For Businesses | Valimail](https://www.valimail.com/)

<aside>
💡

CNN uses Valimail.

</aside>

# Resources

[Untitled](Setup%20DMARC%20monitoring%20on%20domain/Untitled%2014437367d0b381d1b512fa618ec5f176.csv)
