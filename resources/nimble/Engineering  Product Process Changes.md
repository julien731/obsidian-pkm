---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2023-08-10
---

# Engineering <> Product Process Changes

# Challenges

We are currently facing a significant issue with delivery. I don’t think that there is only 1 reason for it. Like most things, it’s a combination of factors. One of those factors which might be the most impactful is the the isolation of the engineering team both in terms of product development and in terms of business.

## Product Isolation

- Focus on “closing user stories” without much critical thinking about the product. The [“backlog creation inefficiencies”](https://www.notion.so/2023-04-Engineering-Feedback-1f86a1a9f239401782ee5c7b7c93d6cb?pvs=21) topic is a is a reflection of that.
- Expect to receive very comprehensive and extremely precise user stories at all levels (UI, backend, integrate). Pushback on anything that is not crystal clear on a technical level.
- Request extremely granular breakdown.
    - Example: the case of Gulf’s return request screen
        - [10 stories per app.](https://app.shortcut.com/gulf-energy/epic/59169?group_by=group_id&vc_group_by=day&ct_workflow=all&cf_workflow=500066598)
        
        [https://www.figma.com/file/XcBjvy2mJRtQsQMHo71N7F/Gulf-Approval---UI?type=design&node-id=300-27491&t=e0DFHvzNkVwYktKf-4](https://www.figma.com/file/XcBjvy2mJRtQsQMHo71N7F/Gulf-Approval---UI?type=design&node-id=300-27491&t=e0DFHvzNkVwYktKf-4)
        
        - [Requested here.](https://app.shortcut.com/gulf-energy/story/59528/ui-as-a-user-i-can-return-a-payment-request#activity-62526)
- Yet developers create stories that are sometimes huge, where the story type doesn’t match its description.
    - Example: the case of Flexi
        - [Stories like this one](https://app.shortcut.com/ewa-payroll/story/64585/review-the-structure-of-the-code-for-the-sso-1-10-reports-txt-and-pdf). It’s a chore with 540 LOC added titled “review”
        - [8-points story](https://app.shortcut.com/ewa-payroll/story/63215/backend-as-a-tenant-admin-i-can-download-sso-1-10-as-a-pdf-file-cover-page)

## Business Isolation

- Unplanned and un-communicated changes often focused on the technology rather than the business needs and risks.
    - Example: the case of the linting on easyHotel
    - Example: the case of broken routes on easyHotel
        - https://nimble-co.slack.com/archives/C04AVC5HHA5/p1684811171153139?thread_ts=1684757565.697269&cid=C04AVC5HHA5
        - https://github.com/easyhoteluk/easyhotel.react/pull/535
        - [https://app.shortcut.com/easyhotel/story/54169/ui-as-a-user-i-see-an-updated-header-on-the-booking-page](https://app.shortcut.com/easyhotel/story/54169/ui-as-a-user-i-see-an-updated-header-on-the-booking-page)
- Lack of ownership. There is often a discrepancy between the theoretical health of a project (usually represented by “all metrics being in the green”) and the output of the team.
    - I think that a contributing factor is the confusion between the EL and TL roles. For having heard direct feedback, there is an accountability gap.
    - Example: Flexi is not delivering value very fast despite a large team
        
        ![[https://docs.google.com/spreadsheets/d/148l9pt_BUoEp57Q4hW3ViSV96tO9yV8nsWP1uftsAyo/edit?usp=sharing](https://docs.google.com/spreadsheets/d/148l9pt_BUoEp57Q4hW3ViSV96tO9yV8nsWP1uftsAyo/edit?usp=sharing)](Engineering%20Challenges%20I%E2%80%99m%20Seeing/Untitled.png)
        
        [https://docs.google.com/spreadsheets/d/148l9pt_BUoEp57Q4hW3ViSV96tO9yV8nsWP1uftsAyo/edit?usp=sharing](https://docs.google.com/spreadsheets/d/148l9pt_BUoEp57Q4hW3ViSV96tO9yV8nsWP1uftsAyo/edit?usp=sharing)
        
    - Example: Flexi having an 33 points ongoing for 4 sprints
        
        [https://app.shortcut.com/ewa-payroll/epic/55449?cf_workflow=500079826&ct_workflow=all&group_by=story_type&vc_group_by=day](https://app.shortcut.com/ewa-payroll/epic/55449?cf_workflow=500079826&ct_workflow=all&group_by=story_type&vc_group_by=day)
        

# Solutions

|  | Product | Engineering |
| --- | --- | --- |
| Prioritization | Product Managers, especially juniors, need to do a more thorough “technical prioritization” i.e., ensuring that developers aren’t stepping on each-other’s toes. | Engineers need to voice their concerns if/when the technical prioritization is sub-optimal or a plain bottleneck. |
| Ownership |  | Engineers need to have a better understanding of what they are building and they should be able to contribute to the product development beyond just writing code. |
| Communication | PMs need to communicate more, and better, with the engineering team. They must share longer-term vision unless impossible (e.g., TPC). | Engineers must communicate challenges and technical needs consistently. |
| Business Involvement | - PMs need to pay more attention to our clients’ business (e.g., eH).
- PMs should involve TLs/ELs in conversations (good or bad) with stakeholders. | Engineers needs to connect their work with the impact on the product and the business (for better and for worse). |

# Well-functioning Workflows

As always, it is not a black-or-white situation. All team members are approaching things differently. I want to give a shout out to two team members in particular as a way to highlight a collaborative methodology which I think is more efficient and fruitful.

- Andy is usually doing a great job with ensuring that the work is “technically prioritized” and that his team is assigned efficiently. He is also contributing to adding technical and implementation-level details to user stories for the engineering team.
- Mike has showed excellent collaboration skills and has done a great job at reviewing, assessing, and preparing work with PMs.

# Re-Defining our Engineering Focus

Being engineering-focused is one of our strengths. This should not change. However, our definition of it needs to evolve.

As of today, this engineering focus is driving us towards an engineering-only approach where PMs are expected to provide engineer-level details through user stories and engineers wait for a new story, close it, and repeat.

We need to adjust our mindset. Everyone needs to at least be aware of the business objectives and outcomes, and everyone should contribute to building the right product the right way.

As this sounds like a big change, which it is, I will start by outlining what I an NOT suggesting to avoid misunderstandings.

## What I am NOT Suggesting

- Changing our development workflows.
- Changing how we break work down.
- Changing our technical approach to building solutions.

## What I am Suggesting

- PMs need to increase focus on the business and decrease focus on engineering-level details.
    - Change the way we write user stories. The value of PMs writing detailed stories for UI, backend, and integration separately is too low. The breakdown can remain the same but engineers need be the ones defining the breakdown. PMs should write one story per feature. The UI/backend/integrate breakdown should come from engineers.
- ELs and/or TLs need to join the important client meetings.
- There must be clear responsibility and accountability on the technical deliverables.