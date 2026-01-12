---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2023-02-01
---

# Product Leadership - Retro Notes

# Ongoing Initiatives

| Initiative | Leader | Status |
| --- | --- | --- |
| Less granular user stories (combining UI+Integrate+Backend) | @Julien Liabeuf  | Successful, as of September 13, 2024. |
| Empowering employees to deliver for more value (more freedom to experiment) | @Julien Vernet @Julien Liabeuf @Andrea Perini  | **Unstarted** |

[[Empowering employees to deliver for more value (more freedom to experiment)]]

# Meeting Notes

- February 1, 2023
    
    ## Notes
    
    - Redefining the different states of the initiative
    - [Update the recruitment process (including the Product Challenge)](https://www.notion.so/Update-the-recruitment-process-including-the-Product-Challenge-14361bdb1df24f918e006e0e82d5975a?pvs=21)
        - Find & cleanup old resources
        - Prepare a high-level plan
        - Share with Julien
        - Define expectations for collaboration
- March 1, 2023
    
    ## Agenda
    
    - [ ]  Set owners for all roadmap-related initiatives
    
    ## Notes
    
- March 1, 2024
    
    Ongoing initiatives:
    
    - Event Tracking guidelines → PR on GitHub
    - Nimble website on Webflow with hosted as path → Seems possible with Cloudflare Workers → Next steps POC?
- May 24, 2023
    - Did we start checking in on other projects (to phase out)?
        - Neither @Julien Liabeuf nor @Julien Vernet tried this out yet.
    - **360 feedbacks are coming next month**. One idea is to replace the existing feedback form with something way more simple (What Went Well, What Could Be Better).
        - [Notes](https://www.notion.so/Notes-b41a909b67c444ba8c7d439668aa654f?pvs=21)
        - Less “framework” | More open feedback → Reviewers can provide the feedback as it comes.
        - Fewer people are involved → For PMs, perhaps TL & EL is enough.
        
        > A culture of candor does not mean that you can speak your mind without concern for how it will impact others. On the contrary, it requires that everyone think carefully about the **4A guidelines**. This requires reflection and sometimes preparation before you give feedback, as well as monitoring and coaching from those in charge. ([Location 771](https://readwise.io/to_kindle?action=open&asin=B081Y3R657&location=771))
        > 
        
        > Following other general critical-feedback guidelines—such as “Never give criticism when you’re still angry” and “Use a calm voice when giving corrective feedback”—could have helped too. ([Location 788](https://readwise.io/to_kindle?action=open&asin=B081Y3R657&location=788))
        > 
    - How to remind people to provide feedback? Perhaps a Slack bot that posts a link to the feedback form inside the `#project-internal`, prompting devs and PMs to provide feedback.
        - A reminder could be sent anytime during working hours within 2-4 weeks.
    - Project updates.
        - It not being used thoroughly anymore. Some possible reasons:
            - Format is too strict.
            - Too many places where some sort of updates are shared (1-on-1, chapter retro, etc).
        - We should replace the strict format by more accountability from PMs. It is the PM’s responsibility to share important information.
- August 2, 2023
    - 
- November 9, 2023
    - PM / Design Reviews
    - Product Initiatives
- January 4, 2024
    - First meeting with @Andrea Perini
- March 27, 2024
    - Not much news from either of us regarding product initiative.
    - Updates from the JFC projects
        - **Design**
            - The team is doing great despite several changes.
            - We could make more informed decision with more data.
            - We also need to do better at documenting decisions.
            - Action: Figuring out the best way to separate the different phases of development on the design files
        - **Product**
            - Lots of refactoring happening on the Mulesoft apps. Hard to keep track of the changes. Some changes are breaking (e.g., the CBTL pagination got broken).
                - Action: Need to look into integration testing to prevent the above errors from happening
            - Aiden creates too much noise while questioning our decisions (e.g., GT API does not return pagination data… which leads to having to make one call).
        - **Overall**
            - Clients don’t really know how to work agile.
- May 2, 2024
    - Andrea is organizing a knowledge-sharing session with the design team tomorrow. The design “version control” may be discussed.
    - Resolving comments (or not resolving them creates friction for the design team). There might be a process required to close open comments that are old/inactive. This would help to have better visibility on the active discussions.
        - Designers could decide to **close comments older than one week**. Else, if it’s a hot topic and it does not look like it’s resolved, the designer could follow up.
        - Designers could also make a **list on Slack for the pending topics** (with link to Figma comments). This can be shared internally but externally as well if it’s pending a response from client stakeholders.
- June 19, 2024
    
    @Julien Liabeuf @Andrea Perini 
    
    - Any progress on [[the above]]?
    - Recruitment
        - Design candidate impossible to communicate with (again)
        - New recruit: first program manager.
            - She had a resume that would have got her profile discarded → Challenge the candidate if the profile is somewhat still interesting.
    - Chapter retrospective: it needs to change.
        - [Product Chapter Retro Update](https://www.notion.so/Product-Chapter-Retro-Update-e5f5a490bed44dec88b7d5e644035a4e?pvs=21)
        - It’s more of a social club, getting people together and open up, have a laugh. This is still important
        - No much value to each team member on visibility on projects, challenges
        - 📣 **Reduce cadence to one monthly event**
            - Perhaps also change the topics:
                - What interesting thing did you work on the past month?
                - Do you have anything cool to share?
                - Any interesting challenge you had to solve?
            - Optional presentation
            - Possibly rename the event: this is not an actual retrospective → Perhaps something like “Product Team Catch Up”
            - Ideas from Gemini: https://docs.google.com/document/d/1NBDrKAiOvCV1Y-lcjw2RnML0NCpV8e9VAmjFgEAQvi0/edit?usp=sharing
        - @Julien Vernet would be more interested in doing project retrospectives with engineering (what went well, what could be better, how to make the planning meeting more engaging?)
    - Another topic from @Julien Liabeuf: we need to do something about **Daily Standups on Slack**
        - [Product Chapter Daily Standup Update](https://www.notion.so/Product-Chapter-Daily-Standup-Update-d03dc8d2be6f42229e694311a4355eab?pvs=21)
        - Not very valuable, it’s mainly a todolist
        - It’s chapter based, so not relevant for all
        - How to bring value back?
            - Project-based standup
- July 24, 2024
    - **Daily Standup**: does the new standup work well for us?
        - @Julien Vernet likes it
        - @Andrea Perini not much impact yet
        - Next step: check with engineering on the feedback
    - **Chapter retrospective**: what do we need to do next?
        - Jack wants to know how to make it better, as the new Chapter Lead.
        - Use the next July 26, 2024 meeting to announce to the team that we want to make changes
            - Change from bi-weekly to monthly event
            - Ask everyone what they would expect from the chapter retro
            - What value are teammates expecting from the meeting?
        - @Julien Vernet will join the next Android chapter retro
    - **Changes to backlog management**
        - @Julien Liabeuf has been trying out to combine UI+Integrate+Backend
        - Feedback from PM
            - Significantly better: preparing and testing the stories goes much faster
            - QA: no dependencies between the ticket
            - Possibly better sprint performance
        - Feedback from Engineers
            - Everyone seems to be happy with it
- September 13, 2024
    
    ## **Problem statement: the clients have the wrong focus**
    
    - JB examples:
        - Focusing on Unhappy paths (lots of noise), while the place search results are garbage.
        - No proper 3PL integration, which is one of the biggest pain points on the existing app (how do you compete with food aggregators, which offer accurate estimations and tracking).
    - CBTL examples:
        - Known POS performance issues for a while. But nothing being done.
        - Known no order management at all -> Confusing UX
    
    ### **Nimble’s responsibility & real added-value as consultants**
    
    - Clearly centralizing and raising the risks (over and over again). **This is where we currently fail**. (we knew all the of the risks, we but we don’t raise them clearly enough, we don’t assess the overall impact on the project, and we don’t push the relevant parties to resolve them)
    - Confluence + Slack message that is pinned. Each PM reminds the client of the progress on those risks (or lack of)
    - PM needs to focus less on the execution (backlog management, QA) and more on the business risks which could lead to project failures.
    - **How to have more impact?**
        - What guidelines/recommendations/examples can the leadership provide? As leaders, we must be enablers, allowing others to deliver more value.
    
    ## **Getting better at mentoring**
    
    - **How to answer: how can I grow in my role?**
        - We need to stick to some Principles - @Julien Liabeuf to add more on this.
            - Impact
    
    ## Helping others to have more impact
    
    See [[Empowering employees to deliver for more value (more freedom to experiment)]]