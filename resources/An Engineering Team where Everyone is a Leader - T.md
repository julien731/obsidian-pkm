---
type: resource
created: 2026-01-10
status: active
url: https://blog.pragmaticengineer.com/a-team-where-everyone-is-a-leader/
tags:
  - leadership
related:
  - "[[Product Manager Track]]"
migrated_from: notion
migrated_at: 2026-01-10
---

# An Engineering Team where Everyone is a Leader - The Pragmatic Engineer


> The project went badly. It went so south that I had to ask a previous project lead to step in, to get the project back on track. Going through what went wrong, it turned out that the first-time project lead found the expectations on leading too vague. I put together these expectations for someone who'd led projects before, and wanted to avoid telling them "how" to do things. Yet, for people with no experience, telling them "how" was important.
> 

> **I took a more "prescriptive" approach with first-time project leads**, going forward. I suggested them to follow certain processes to the T - kickoff meeting following a template, daily standups, weekly emails based on a template. I asked them to humor this for the first time, and that on their next project, they will be free to choose their tools more freely. Just experience out how these "standard" tools worked, for the duration of the whole project. I put the [Checklist for first-time projects](https://docs.google.com/document/d/1kngKHUCS0DHNvZAO8PfkcsTD4Mq7b11L09RIaVpQnwI/edit#heading=h.wihhv82rdyr6) part in the guiding document in place at this time.
> 

![group-of-leaders.jpg](An%20Engineering%20Team%20where%20Everyone%20is%20a%20Leader%20-%20T/group-of-leaders.jpg)

Having worked for a decade as an engineer at various companies, I noticed how most teams in software often have "the" manager and "the" tech lead or "the" senior engineer. These are the decision-makers and ones that lead all projects. Many engineers go to these people asking, *"What do you think I should do?"* or *"Can you tell me what is next?"*. People would ask for permission, over forgiveness - and get scolded when they went ahead without involving these people. In an environment like this, becoming a tech lead is challenging for others - especially as long as the existing tech lead is on the team. At bigger companies, I saw talented engineers switch teams internally, to get this opportunity, on another team.

**When I [moved from engineering to engineering management](https://blog.pragmaticengineer.com/things-ive-learned-transitioning-from-engineer-to-engineering-manager/), I wanted to build a team where everyone can be a leader - and everyone would act as an owner**. A group where every member has the skills, confidence, and empowerment to take initiative, make decisions, and lead others. Where, when people saw problems, they would think, "let me take the lead in solving this issue." I wanted to do this because I believed it would lead to better execution, faster professional growth, and people staying with the team longer.

Initially, my team was a team of eight engineers, from juniors to more senior members. Two years later, I have a team of triple the size, where most people have led a significant project, with mentorship/coaching support from a more experienced leader. Professional growth followed, with all the original eight people [promoted to the next level](https://blog.pragmaticengineer.com/software-engineering-promotions/), alongside a few others. Attrition has been low, and people seem to like being on the team.

**This post is a summary of the approach and tools I've used to build an engineering team, where everyone is a leader by rotating project lead responsibilities within the team.** It includes sharing of the [project management expectations Google Docs guide that my team uses](https://docs.google.com/document/d/1kngKHUCS0DHNvZAO8PfkcsTD4Mq7b11L09RIaVpQnwI/edit). It's also a reflection on the pain points that came with this approach. I can't advocate for how universally this approach could work. However, based on my results, it is something I suggest engineering leaders - especially frontline managers - consider as an option.

## Inspiration

My inspiration for having more people lead a team came from three main places: a personal itch to scratch, a book, and a podcast.

**My personal itch to scratch** was that I started to become the bottleneck for project management on my team. When I joined the team in 2016, we had few engineers who have led larger projects before. I joined with lots of experience behind my back: I was a scrum master at Skype, and a team lead at Skyscanner. I became the person who set up a [basic project management framework](https://blog.pragmaticengineer.com/efficient-software-project-management-at-its-roots/) that worked well enough for our environment. However, I found myself running too many projects at the same time. At Uber, we had no project managers at the time, so I decided to get other engineers involved. As a first step, I put an engineering project management guide together; then, I started to mentor a few first-time project leads.

**The book that inspired me** to break the status quo of one "main" tech lead per team was [Turn The Ship Around.](https://www.amazon.com/gp/product/1591846404/ref=as_li_tl?ie=UTF8&tag=gregdoesit-20&camp=1789&creative=9325&linkCode=as2&creativeASIN=1591846404&linkId=e8c70496cb99352cf3ff33c719346d5f) It's a story about how a captain at the navy flips the traditional top-down operation mode upside down to bottoms-up initiative-taking - and gets better results than any other team in the army. It is an easy read, based on a true story and involves intricate details on nuclear submarines. The captain started a cultural shift with a seemingly small thing. He asked people to start all their sentences with *"I intend to do {this and this}, because…"* over waiting for orders to be given and following those orders without thinking.

**The podcast that hit a nerve with me** was the [HBR IdeaCast](https://www.listennotes.com/podcasts/hbr-ideacast-harvard-business-review--5V96nWKdQw/) interview with [Sue Ashford](https://twitter.com/sueashford?lang=hu), professor at Michigan's Ross School of Business, titled [Why everyone should see themselves as a leader](https://www.listennotes.com/podcasts/hbr-ideacast/592-why-everyone-should-see-574rO01BYCl/). She talks about what she's learned about shared leadership and how organizations that adopted this model were efficient. A quote that particularly struck me was, *"The more you have a leader identity, the less risk you see in leading. The less risk you see in leading, the more you develop a leader identity."*

Sue went on to say that shared leadership has a lot of payoff in places where things are moving fast, are complex, and have many dependencies. In places like this, people who take leader-like actions are more efficient than those who wait to go up and down the chain. What she was talking about sounded exactly like software development. She suggested ways to encourage this behavior: *"Every manager could be growing the leaders around her. One strategy for a boss is granting the identity in a public setting."* Which reinforced the approach I was planning to take.

## One project, one engineering lead

My team of 8 engineers, was running 2-3 parallel projects, at the time. The first thing I settled on was to have one publicly announced engineering lead per project. I did this to make ownership clear - similar to how Sue Ashford was suggesting to grant a leader identity in a public setting. I wanted to give autonomy to make decisions to the project lead - but at the same time, have them take responsibility for these decisions.

As an engineering manager, I am the one accountable and responsible for my team delivering projects. I delegated the responsibility - deciding *how* to do things - but kept the accountability. If the project would fail, and someone would get in trouble, it would still be me, not the project lead.

## Setting expectations on leadership

Up to this point, I was "the" project lead on the team. When I sat down with one of the experienced engineers, asking them to head up the next project, their first question was what I'm expecting from them. I didn't have a straight answer, so I asked for some time to collect my thoughts on what I really was asking.

I ended up [summarizing expectations in a document](https://docs.google.com/document/d/1kngKHUCS0DHNvZAO8PfkcsTD4Mq7b11L09RIaVpQnwI/edit), editable by the team. I wrote the first version. Then the team ended up modifying this document after each project. Most of the modifications were additions and tweaks. These were the seven expectations I asked project leads to go by:

1. **Collaboration**. Set up a framework for collaboration.
2. **Milestones**. Break down the project into milestones & provide estimates on these.
3. **Communication**. Communicate project status to stakeholders.
4. **Risks**. Manage and call out risks.
5. **Delegate**. Help the team ship and delegate (both to the team and upwards).
6. **Motivation**. Motivate the team on the way.
7. **Quality**. Ensure the overall quality and reliability of the shipped product.

**I aimed to set expectations to avoid micro-managing**. I tried to define outcomes I was looking for, but not the specific implementations. For example, I like to run daily standups and have always done this with my team. However, this was not the outcome I was expecting from a lead: I merely expected them to have regular updates with the team. The format and cadence are up to them. Some teams prefer async updates; others like to do three-times-a-week standups. I added ideas they can consider but made it clear that they can choose whatever they would like to.

### Join the newsletter

[Subscribe to my newsletter](https://newsletter.pragmaticengineer.com/) to get weekly advice, observations and inspiration for engineering managers and senior engineers.

## Mentoring, then coaching the first few leaders

The first few project leads were experienced engineers, who either have led projects before or have observed others do so. I joined all team status updates, observing how things were going. I often had post-standup catchups with the project leads, giving feedback and suggestions. I had more frequent 1:1s with the project lead in the initial phases of the project and gathered feedback from other team members.

After the first few weeks of a project, the new leads started to feel more comfortable in their role. They took more initiative, and my role slowly changed from mentoring - giving advice - to coaching - asking open-ended questions.

## Transparency and accountability via weekly, written updates

A challenge that leaders like myself have when delegating project leadership is being certain that things are going the right way. I was still accountable in the case the project went south. However, I was keen not to get too involved in the day-to-day, giving space for the project lead to grow. I wanted to observe but not interfere.

One of the powerful tools I've found leads and teams to hold themselves accountable was a short email status update sent out by the team every week. The update would summarise progress towards the next milestone, how this process changed from last time, and progress the previous week. Risks and delays would explicitly be called out, along with plans to mitigate. This update would be emailed to me, key stakeholders, and all of the team members.

**This written update turned out to be a vital tool in growing strong project leads**. First, it requires concise and good writing, keeping the target audience in mind - the stakeholders. For any engineering leadership position, [good writing is a key skill](https://blog.pragmaticengineer.com/on-writing-well/). Second, it forced the project lead to step out of the engineering mindset, and empathize about things stakeholders cared about. Stakeholders typically care about [milestone estimates](https://blog.pragmaticengineer.com/yes-you-should-estimate/), evidence on the progress being made towards those estimates. In the case of risks and scope changes, they care about what changes in scope mean for the business. Finally, stakeholders ended up often pinging the project lead directly. This forced the lead to strengthen their stakeholder management skills.

## Preparing junior members to lead a project

As the first few project leads shipped their projects, more team members expressed interest in leading. I was generally supportive of giving people a go, who had some past tech lead experience. However, many of the team had none. Would I be setting them up to fail, if they started to lead a project, with no previous experience?

**First-time project leads needed to strengthen leadership skills before being thrown into deep water.** There are multiple things a project lead needs to do, from facilitating meetings, reporting, calling out risks, coming up with mitigation strategies, and others. Could they start to practice a few of these skills on a project they are not formally leading?

Working with the existing project leads, I suggested areas they delegate to more junior members, showing them ways to do it, then mentoring them. For example, a more junior member started to facilitate the regular standup, getting feedback from the project lead afterward. Preparing for planning meetings, or leading certain stakeholder meetings started to be done by less experienced members - after plenty of preparation, and the project lead being present to support.

Even though these engineers were not yet leading the whole project, they were building up the muscles needed to do so. Even better, the project lead was strengthening their ability to mentor well, while also delegating some of their responsibilities, allowing them to focus more on coding, or other, high-leverage activities.

## First-time leaders: directing, then mentoring

After many months, the first engineer, who had never led a project before, seemed ready. I announced this person would be leading the project, gave them the same high-level guidance as I did with past project leads, then sat back to observe.

The project went badly. It went so south that I had to ask a previous project lead to step in, to get the project back on track. Going through what went wrong, it turned out that the first-time project lead found the expectations on leading too vague. I put together these expectations for someone who'd led projects before, and wanted to avoid telling them "how" to do things. Yet, for people with no experience, telling them "how" was important.

**I took a more "prescriptive" approach with first-time project leads**, going forward. I suggested them to follow certain processes to the T - kickoff meeting following a template, daily standups, weekly emails based on a template. I asked them to humor this for the first time, and that on their next project, they will be free to choose their tools more freely. Just experience out how these "standard" tools worked, for the duration of the whole project. I put the [Checklist for first-time projects](https://docs.google.com/document/d/1kngKHUCS0DHNvZAO8PfkcsTD4Mq7b11L09RIaVpQnwI/edit#heading=h.wihhv82rdyr6) part in the guiding document in place at this time.

**I made sure to have an experienced project mentor and support the first-time lead,** helping them succeed. I made it clear to this experienced lead that the first-time project lead's success is their success. By this time, several had successfully led projects, so finding mentors was not hard. In hindsight, this mentorship setup was more important than the "prescriptive" project management approach.

## A team of leaders - a high-performing team

About 1.5 years into starting this process, 10 of the now 12 people on the team had led complex projects, heading up teams of multiple engineers. And the payoffs started to be more visible.

**The perception of the team improved greatly**. Stakeholders started to appreciate - and depend on - the weekly status update emails, and loved the transparency these updates provided. Turns out that unexpected delays are easier to work through, when stakeholders trust the team, and understand what happens under the hood.

**The approach of engineers owning features end-to-end became more sustainable across the team.** In a sprint-based environment, most engineers tend to "forget" about a feature, after development is complete. They move on and pick up the next piece of work. This is despite the project far from being complete: rollout, A/B testing and user feedback are still to come - and all these parts carry additional project risk. We adopted the *"project lead is the first one on the team, last one off the team"* mindset. As much of the team transitioned to the new project, the project lead was still engaged, looking at usage numbers, figuring out if something needed fixing. In the traditional model of one tech lead per team, this setup would have burnt out the one lead. However, an ongoing rotation made this kind of responsible ownership far more sustainable.

**Members of the team saw themselves as leaders, even when not being assigned a project lead role**. When interacting with stakeholders, they made decisions on the spot, informing relevant parties. Asking for forgiveness, not permission, became the norm. This itself should not have been a big deal, as acting like owners is an Uber culture value. What I found interesting was how quickly new starts adopted this leader mindset.

**Finally, professional growth on the team was consistently high**, and attrition consistently low. I mentioned how I had a great run with promotions - all of the [original team members were promoted](https://blog.pragmaticengineer.com/software-engineering-promotions/) in the first two years of working together. In many cases, demonstrating quality leadership and mentoring others to become efficient leaders were key reasons these promotions went through. Likely related to professional growth, very few people decided to leave the team. Those who did, moved to teams owning domains they had more interest in, quickly becoming a goto person on their new teams as well.

## Tensions and challenges

This process was not all roses and butterflies: difficulties also came up on the way.

**Engineers being anxious to lead** was the first challenge I had to face. As I shared my plan on how I'd like to see everyone eventually lead a project, more people expressed an interest than there were opportunities to lead. Even though I made it clear, that not everyone can lead, at the same time, some people started to get impatient. This was the point where I began suggesting that people take on ownership on parts of the project: specifically, project leads delegating smaller parts.

Smaller, one-person side-projects were also an area I experimented with. For those who were eager to lead, I suggested we treat one of the smaller things they worked on as a project. I assigned a mentor to them, to make it a two-person team, and asked them to follow the usual expectations, from having a kickoff, incremental milestones, and weekly updates. You might think this was an overkill. Perhaps so, but the people doing this loved it - and improved their leadership skills on a small, non-critical project.

**Too many parallel, small projects** also became a problem. There was a point when my team was working in pairs, across several projects, working disconnected as a whole. To solve this, we started to plan more ahead. I also tried to "mix and match" parallel projects, so larger and smaller efforts would be better balanced.

**The time-consuming part of planning and resourcing projects** was the main downside of this approach. I found myself and our product manager becoming the bottleneck in planning out who will work on what project, next, and who will be the lead. Initially, I did not mind: the payoff and professional growth for team members made up for a bit of extra time spent here. As the team is growing, we'll have to decide if we keep this structure, with smaller teams, or not.

**"But I want to code, not do project management…"** Early on, a few engineers expressed worry that I'm asking them to do project management. *"Isn't that what project managers are for?"* - they asked. While we do have [technical project managers](https://eng.uber.com/finding-balance/) at Uber, they manage really large projects that span tens of teams, and just getting a status update can take days of poking different people. For projects in scope of the team, we are left to our own devices.

I suggested two options to them:

1. **Either we have another person do the project management - and they have no say in how this will be done**. Perhaps we even entertain the idea of an external hire - who is not an engineer. They won't have the engineering context, so they'll ask for more frequent updates, and have more regular check-in meetings. Also, anytime something seems to be delayed, they will have to come to the engineers to ask them how and what can be mitigated.
2. **Or they do the project management - doing so with autonomy, and learn a new skill**. Do as little project management they'd like to, as long as we have a way to know where we are, and if we are on track. While doing so, they build skills that could be pretty useful - universally. If they join a tech startup, the first few tech hires will all be software engineers, who will need someone to help them with getting projects done. Or if they move up the ladder, later, there will be times when someone needs to fill in for the technical project manager. It would be nice to know how it's done, no?

After this chat, everyone went with option #2. Back then, all our projects were small enough to manage ourselves. As of today, we do lean on technical project managers for some of the cross-office, cross-team, cross-organization projects, where there are far too many stakeholders for an engineer to manage alongside the engineering work.

## More efficient and engaged engineering teams: teams where everyone is a leader

I personally had great success in building an engineering team, where everyone saw themselves as leaders - and has the opportunity to exercise this skill. Beyond the additional logistics load on the manager, to have enough, good-sized projects to lead, I saw little downsides to this approach.

What worked for me, in my environment, might not work for you. But do keep in mind what Sue Ashford had to say on shared leadership: *"In a world, where things are moving much faster than before, things are more complex, things are more ambitious. Where work is inter-dependent and coordination and cooperation is required, then shared leadership can have a lot of payoff. (…) **We need people taking leader-like actions in more places**."*
