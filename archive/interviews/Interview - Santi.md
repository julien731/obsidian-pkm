---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2025-06-09
tags:
  - interview
---

# Interview - Santi

Summary

This transcript covers a second-round interview between Julien (Chief of Product and Partner at Nimble) and Santee, a candidate for a technical product manager role. The interview explored Santee's experience transitioning from engineering to product management, technical skills, and alignment with Nimble's expectations.

### Career Background Discussion

Santee shared that their current product leadership role has been their best position so far. They transitioned from engineering to product management because they wanted to be more involved in problem identification and solution development rather than being limited to the engineering side. This move allowed them to combine their technical background with new product skills, bringing technical capabilities that other product managers at their company lacked.

### Technical Product Management Experience

Santee discussed challenges faced when transitioning to product management, particularly with stakeholder management:

- Learning to work with different stakeholders and their varied communication styles
- Building processes to align different parties toward shared goals
- Developing skills to properly scope and release products

### Technical Discussion

The interview included a detailed technical conversation about feature delivery and performance optimization:

- Santee described their process for checking new features/bug fixes:
    - Verifying deployment doesn't affect stable releases
    - Using feature flags for controlled rollouts
    - Communicating with stakeholders (customer service, marketing, sales)
    - Handling app update requirements differently than web updates
- They also discussed a challenging technical issue involving calculation problems and performance issues in a payroll system:
    - The problem involved multiple modules (payroll, attendance, leave)
    - Performance issues required database restructuring
    - Santee's approach was to clarify responsibilities between teams and establish clear API contracts

### Nimble's Technical PM Expectations

Julien emphasized that Nimble expects technical PMs to:

- Dive deeply into technical issues rather than just delegating to engineers
- Understand the root causes of problems (e.g., running SQL queries to identify database issues)
- Combine technical understanding with business context to make informed decisions
- Proactively test for edge cases (like performance with large data sets)
- Take complete ownership of product quality and delivery

### Nimble's Product Information

Julien shared information about Nimble's internal product:

- A SaaS solution for restaurant chain management
- Powers approximately 1,500 stores across multiple countries
- Handles end-to-end restaurant operations (e-commerce, POS, self-ordering kiosks, order management, kitchen display systems)
- Developed based on solving recurring problems identified through client work

### Next Steps

- [] Julien to debrief with the talent acquisition team
- [] Santee to expect feedback later in the week

Notes

Transcript

Hello. Hello. Good morning, Santee. How are you? Yeah, I'm fine. How about you? All good, all good. Thank you. All right, so how how's everything going on your side on your side of Asia you're in Jakarta at the moment, is that right? How is everything going there? I think it's good. Nothing going wrong here.

Do you have rainy weather already in Jakarta? I think today is not rainy, but yesterday it was. So it started for you as well? We have rained quite often in Bangkok as well now. It's already in progress, all the raining season. Alright, so it's nice to meet you Santee. I'm Julien, I'm the Chief of Product and Partner here at Nimble.

So before we get started, just want to give you a very quick recap of the process and also let you know a little bit more about what to expect for today's interview. So as a very quick reminder, this is currently a second round of interview, which marks the end of our recruitment pipeline.

Which means that after this interview, the next step is simply going to be a debrief between me and the TA team. And we're going to make a decision at that point. And you should hear back from us sometime later this week. Now, regarding today's interview more specifically, so there's going to be two parts to the interview, so a little bit similar to the first interview you went through. The first part is also a bit of a standardized part where I'm going to go through a couple of questions that are standardized questions.

Same questions that we ask every candidate. That is a much shorter list of questions, though, as compared to the first interview. It's a much shorter list. And the approach here, as you will see, we'll probably dive a little bit deeper in some of the questions.

Although it's the structured part of the interview, the goal is to try to go as deep as possible on some of the things that you've done and your past experiences. How you've addressed specific challenges, right? So that's gonna be kind of like the structured part. And after that, again, we should have, we will have some time left to discuss maybe other topics, right? So maybe, depending on the interviews, right, sometimes that structured part, we end up going very deep on a number of topics and that takes a lot of time.

But in any case, we'll have a little bit of time left in the end, in case you maybe have any new questions that you want to go through, any comments that you have, if there's anything that you want to discuss about the company, about the team, about the challenge that you've gone through.

And I would love also to hear a little bit about your thoughts about the challenge when we get there. So yeah, that's for how today's interview is going to happen. Okay, so if everything is good and clear on your end, I'm gonna go ahead then with these first questions. And so before I actually start with the questions, a very quick.

A note for you here is that the first two questions are going to be very focused on your previous roles in previous companies, just for the sake of clarity. I'm already familiar with your experience, with your background, so I am not looking for a detailed history of all of your job positions.

What I am interested in is to hear about your actual experiences there, with the company, with the team, with the projects that you've been working on. And to get this kicked off, the first thing that I would like to actually hear from you is, Which one of the jobs you've held so far, which one has been the best job for you?

Alright, so far all the job that I have been, right, um, I think the last job that I'm currently in, like the current one, the product leader, because It starts from my creative and I don't know if there is a product media at all, so basically I'm just going to be ISA here because my regard is to the concept science.

But as I'm working at Microsoft company, I know there is this new role at the product manager and I'm quite interested about this role because this one is I can talk to the user and really like This is a voice memo. It has been edited to include proper punctuation.

The scope is quite limited on the engineering side for me and we don't really have much safety in the product. So I think moving to the product major I'm really excited about this role that I can really like point out what is the problem that we are going to solve and how to solve the problem.

OK, so how did you end up there? So you mentioned that you were not super familiar with the role, but you're kind of a kind of interested in that. So how did you. How did you land into product management coming from mostly engineering before that? Basically, based on my previous experience as an engineer and also as an engineer, I got to know the product management.

I will just quote a little bit of what the product manager does daily, day-to-day, and what I've done in engineering major too. It's kind of like intersect a little bit like the signal management and the pipeline scoping exhibition as well. So when I'm moving to this new role,

I understand that I don't have the basic of the product manager, but I think they have seen me have some medical background, which as well, and is my capability in those areas, because In my current company, all the product managers don't have this technical capability, so I can bring something new into the company.

In your past roles, you've done engineering work for a number of years. Did you ever work with product managers when you were working as an engineer? Yeah, of course, I work in the product manager. Um, I think my partner is very, like, understand and respect, but really, like, pushing doesn't really know what they're doing really.

I really want to understand our struggling. My partner also wants to hear about the technical stuff that they don't understand. I really want to give that voice. And I think that's a really good trait of the program major, instead of exposing anything to the engineering side. I have a really good connection to my program major.

Yeah, we are not only colleagues, but we are friends also. OK, nice. All right. So now if you think back a little bit, a little bit. further back in your career history. I'd love to hear a little bit more about how you felt about the other companies you've worked at. Where did you have mostly good experiences or did you ever...

Find yourself in difficult environments, in past roles. So how were your experiences before your current job? Sorry, I... What do you mean, like, the other company?

Sorry.

And I think six years and seven years has been that I'm really good with the company because I love working there. The working atmosphere is good. Everyone is so supportive and helpful. And we are going to achieve everything together. For the people, yes, but maybe I will see more about the device code in those companies.

Now, let me think about this question. Because your experience here being a little bit more... Different in the sense that you've basically done product management for about a year, about almost two years now, right? So... Okay, let's see how you want to answer this one, but if you wanna follow up with any sort of question, happy to help guide the answer here.

Overall, what I would like to know is, what do you feel has prepared you in your current job? What would you feel has prepared you to take on greater responsibility?

So what do you think is what I have been taped to make me a really suitable partner? You were open at school? Yes, yes, in a way, yes.

So, I think my previous lives have really lived me very well. They are awesome every time. And if I'm interested, I will take on this role. So basically, from the ISA year, I'm pretty junior. And my lip-sync leads me that, do you want to lead people? Then I said, in my next career, I want to lead people. So they let me try one by one by one people.

People are trying to get back to other team members, how is my leadership going, communication skills. I also gave feedback to another team as well. And I think based on what I'm trying to achieve for Little Big Little Big to increase my scope, I think it will be more graceful and I think I can be more responsible in that way.

Also, I got a call. Maybe I think I need to answer the call a little bit.

Can I take the call first? Yeah, yeah, yeah. Okay, sure. Okay, sorry.

Okay, sorry. Thank you very much. Have a good day.

All right. You get a work call? Yes. Okay, okay. Everything okay? Yeah, okay. All right. So to kind of like summarize a little bit, right, if I understand correctly what you were... What I'm saying is that you've been both kind of eager to take on more responsibility little by little.

One question that I would have for you here is how do you feel about moving from, let's say learning new things little by little to Having to learn a lot Very quickly Hmm I think I'm going to throw out my experience, like I jumped into the product major, I think it's a whole lot deeper responsibility compared to my previous role.

So I think I can say that it's like learning a lot of things that I don't feel comfortable with at first at all. And I think it's much changes impacting to what the possibility that I have right now. So, for the first job in the product manager, I think I have...

I have done a lot of things that I haven't done before, like from scoping, researching, benchmarking, and I would like to say that I struggled a little bit in the first week because No wonder, it's like, led me quite well. And I think what I do is like, I'm talking to my peers, what they do. I'm asking them what I do better.

And then, yeah, I just managed my ways, like learning auto-deductive, like comparing to... Because we have other product managers, so I can see how they work through, like... I can learn from there and from my late school and from there I just adjust it a little bit and it all comes to the way that I am right now.

For a lot of information, I also like getting the information from the AI as well. I haven't known before. And mostly I also have because I'm working in the HR ecosystem, they are HR consultant where I can talk to them directly about the struggle and the pain point and to really get the requirement from them as well.

I see. What would you say has been your biggest challenge in moving into the product management space? Coming from engineering and let's say engineering management. That was your previous role before that. What has been the biggest challenge for you getting into product management?

We can have how we all as a stakeholder can achieve a one-shift goal that we can go directly together. Okay. So in terms of stakeholder management, how are you feeling about stakeholder management these days? And how did you get past that challenge that you faced initially?

Because working with different people, they have different styles. First, I observed what is their work style, how they would communicate, what they would expect. Progressing, always progressing love can be solved in one moment. But myself, partly also because I have another stakeholder, I need to adjust well again this time.

Okay. All right then. So I'll move on to the last question that I have here for this kind of structured part and then after that we can get into a little bit more kind of open-ended conversation. So the last question is moving to very practical territory here and what I'd like to know is, say that your development team just delivered a new feature or just delivered a new bug fix for example.

What are the most important things that you're gonna be checking at that point?

The first thing that I will find out is, is it really human? The deployment for the newest flag is not affecting. What I consider is like the new release cannot be affecting the stable release. So I'll make sure that we can go like this is something that will happen. And we can also select a feature point to feature voice. So we need to open to.

Maybe several user first before going to all 4 builds. And make sure that the improvement on the new graphics is stable enough for several days based on the scope. Communicate through all the stakeholder interactive like the customer service or marketing or sales. If there is a new product release, we need to get involved in marketing and sales.

But if there is a bug fixing, we need to inform the customer service, because maybe this improvement can solve several issues, or maybe this bug solved.

Is there anything that you would approach differently if, say, you're working on a web application? So I think for the apps application, we need to be really careful. . . . . . . . . . updates to the app. So I think for the app, we need to be very strict about the voice. Yeah. Have you ever been in situations like that where you got caught up in something because our review times now started to hinder your plans or started creating bigger problems?

Actually, in my previous role, when I was an artist engineer, it is the app, right? We have a strict schedule and schedule. The newer version can be used by our users. But for the web, it's more flexible. We can do it anytime. It doesn't really put it, not that harmful. This is the upside.

Which is a very good point indeed, is not only do you need all the reviews to be done and the new version to be published, but you also need users to update. How do you deal with that if you ever have any sort of like urgent update that needs to be done?

Is it like solving the bug or the issue from the user side? Yeah, let's imagine for example that there's a pretty severe bug that has been discovered in a version of your app and it's pretty critical, the team gets fixed, pushed out, you get the application released and all that but now the next step is people need to update it, right?

In this situation, if we have like a push of it, so like we presumably have like some technology like If the user goes to this page, we can force the user to update before using the full feature on their phone. If they have the technology in their phone, we can force them to update before using the full feature on their phone.

. . . . . . . We need to send a post-mortem to the user, like, hey, you need to update the version to the newest version to have the full... So the bug is not occurring again. What would be your go-to way to implement this?

Maybe the simplest one is, in my current company, we go to the page, so if the page has a new feature, We have this capability to pause update only just for the page. So, if we have several pages, the user can still use the page that was designated for the pause update, but the new page, we use the new pause update to really use the full capability of the feature on this page.

Yeah. So how would you technically implement this? Oh, so technically implement this?

One of the ideas that I can think of right now is we change the fashion, the general fashion, of the specific page of the feature. And then we have like some config file in the server side. It's the most stable version that users can use. So when the app compares to our config file.

And if the person is lower than the table person, then the app will need to show the post-update notification to force the user to update the page. So if you put that like in a config file is that so that would be what I could config file that that gets How does the app get the the config file?

So I think we need some manual effort, because different pages have different styles of captioning. So every time we release, we take notes on which page is the most stable flagship, and then we update the content file based on the release. Okay, so how does the mobile app get that configuration file?

I think we can use anything like maybe getting the API from this server where I'm showing all the... Sorry, can you repeat your question? Yeah, so your approach that you're thinking now is like to have a configuration file that the app would need to download one way or another. So my question is, why going with a configuration file? Is it because it's typically apps that you work with require some sort of configuration file that gets downloaded anyway, so you just add the variables here?

Why going with a config file system, basically?

It is one of the social that I can think of right now. But I don't think that all of the apps that I have right now is using the Post Malone free file. Two questions on this particular topic. First one is, so you mentioned it can have like a different required version per screen, for example. Do you think it's worth the effort?

to have different minimum required versions per screen or per feature in a given app.

I think the import is quite based on the feature of the page that we have. The more page or the more feature, it will complicate things a lot. But I think we need to balance with the scope that we need to really know the use table. If I would like to suggest in my company, we have several models, like delays, attendances, maybe. Or we can create a stable version for each model, so it's not fixed.

Maybe we have six models and we need to only have six stable versions. But if we like really pointing out the detail, for example, we have the Leap model. And the Leap has another sub-feature. For the East sub-feature, we have the really stable. I think we need to balance out the import to maintain and compact the scope that we want to release by the end.

All right, so let's simplify here a little bit for the sake of our conversation and say, okay, let's say that you only have a minimum required version at the application level, no difference per module or anything like that, just this one minimum required version for the entire application.

So in this context, Can you think of any other way than a configuration file to manage that? Because if you do a configuration file, now you need to add a config file for just that one thing. You need to download that config file on the mobile app. So when are you going to download this?

When are you going to re-download it to make sure it's up to date? Then you also have to manage that file on the back end side of things to make sure it's updated. So I think it's a little not optimal to do this kind of feature. So can you think of any other way to handle that in

Yes, of course. Take your minutes, no problem.

What I can think of is another way of disadvancing from the class. Maybe we can like... To really compare with the config file, but we can't have the backend side to compare the version from the client side to the server side. So if the flying pressure is lower than the saddle pressure that the back end supports, then the back end can return the aero that they have.

So you would do that by sending the app version when you send an API call? Is that what you're thinking? Okay.

OK, OK. Why going this way and not doing the other way around? For example, having the required version sent back from the API and get that comparison done in the application? Yeah, I think that's another approach to solve the issue. I think what you say is we can implement those as well.

Okay. All right then. So, okay. We can, I think, can move forward. Thanks for diving into this a little bit more. Another thing that I would like to know is... If you think back about everything you've been working on right in past couple of years, what would you say has been the most difficult technical challenge that you've been working on?

Thank you for sharing. Do you mean as an engineer or as a product manager? I'm fine with that as well. The only important part of the question here is that I'm interested in a technical challenge.

Maybe I will share the conversation instead of doing it on Facebook. It might help a little bit right now. So this is me.

We have restructured our engineering theme. So currently, we have one senior engineer. And then, the challenges is like, I am not the PM for the parallel model on the attendance model side, so you have all the PMs on the parallel model. We have been discussing together, our PM, the engineering, how we need to solve this issue. So the challenge is like, I don't have any panel contacts.

Because it is a very calculative and mathematical situation. And then I don't get back also with the engineering side, what is it. I'm not sure if you can hear me. I'm not sure if you can hear me. I'm not sure if you can hear me. The engineering part is successful, but it doesn't really impact our current business side right now. And then how we manage the timeline and scoping.

I think this is part of the technical challenge that we face right now. in my situation. So, do you want to ask a question first or? Oh, I mean, go ahead. I'm letting you, I have a few questions, yes, but I'll let you finish first. OK, so yeah, we are still in a discussion phase right now. Something's going on, she just everything. So yeah, like.

Okay, so the source of this is that the calculations are not what It is involving a lot of modules, not only the payroll, but attendance and leave. So we need to one by one find out the root cause. Another issue is the performance issue as well. It's not only the capability part, but the performance as well. The lead engineer told me that we need to restructure our database.

because it's not really effective to support our current data structure, so it's not performing well.

OK, so all right, I have I have a number of questions on that. It's I think it's an interesting it's an interesting case. So you say that you're not sure exactly why, like the calculations are not as they are expected to be. And yet you're talking about a platform reengineering.

Right. So how how can you get to the point where you're talking about reengineering? Some parts of the product if you don't know yet, what is causing the root problem There is another issue as well, like the disbursement part. We already know the root cause and we are already in the development phase of this disbursement engineering part, but from the calculation we are still in like

I'm thinking and solving, like, which one is the root cause for this collision part. But for the performance issue, we already see, like, oh, the database is not really going well, so we need to reframe the database structure. And the part is already going on. But for the composition, we are still in the middle of like finding out which one is not making the composition is not correct.

So you have a basic investigation in progress there? Yes, yes. How did you become aware of that? There's something wrong, right? Like the calculations don't yield the expected results. How did you become aware of that? Um, the first is like. We got many client reports, so the calculation is not right. But for the client report, it's mostly 200 plus. The client doesn't really know how to use the config in the panel system.

We don't have the feature for that client yet, so they are requesting another feature as well. And the third part is like, the feature we already support, but the calculation is not following. So for this part, we gather our main client issue for this part, and then after this we trigger another discussion with the engineering side.

Well, okay. So when that's when this problem came to life, so focusing on the actual bug, right? Not the things requested are just basically new features. We're focusing on that are like. When you started to be aware of this, what did you do?

So, the apparel model is not my scope, actually. But what I do is like, because it's related to my scope in the apparel spot, like, I first like, I want to be best, which one is... So, there is a payroll side, and this is the attendance side, and my stuff is on the attendance side. And then, I gather the PM and the engineering team. The first time, I want to really know how the integration is going to be localized.

Because, yeah, so I get all the stakeholders and I put the documentation together, like, which part of the attendance is going to affect the channel size. And I want to make sure that the responsibility is clear. Which one is my team, and which one is the panel team. So.

Because at that time, I think that the engineering and the product at first doesn't really use the same vocabulary. So, I think from the meeting, we need to use the same vocabulary, and the second, which one is the responsibility for which state. So I want to really make clear which is the best possibility for each team. And then we can solve each team's possibilities separately first, and then...

Before that, I think we need to really make sure the API contract between each team is clear. So, which team is giving what data and which team is helpful with what data. And if that's clear, then we can like improve our current API in separate theme to really resolve.

Okay, so as of now, you don't know yet the root of the problem, right? If I understand correctly, but yeah, have you been able to identify kind of like which module? The problem seems to be coming from? Yeah, from the module, yes. So it's the payroll module that has the problem?

I think both sides have the problem. Like what I said earlier, we don't really define it as a contract-dependent exchange. So I think like, oh, I think this is the federal side. Oh, I think this is the FEM side. And I think that's pretty much the problem because we don't really like...

I don't understand which side of the Lapa it needs to be. Okay. So another thing that you mentioned is about the performance, right? And where here there's some work done on like changing some stuff on the database. Can you tell me a little bit more about this?

Um, so, um, we got a problem because in our dashboard the performance loading is very slow. Like, really affect the typing. And... I ask you to insert the video to, like... Testing all of the features. Either we need to do the test for maybe like a smaller amount of the employee and then we can like...

Make it bigger, bigger, bigger, but we for the smallest. We basically need to do the task for the every feature that we have, but currently I don't think the engineer have. done their part. So now I'm asking the lead engineer to make the test integrated in our workflow.

Cool. So for the performance test, they said to me that they need to fix some query and like creating a more... Maybe I think the database needs to be more normalized, I think he said like that. So what they do right now is like making the data table summary.

The summary database, I think, what is it? Okay. Okay. So it looks like a join every table, but they have one summary database that they can get easily and more faster. Okay. Do you think that is the right approach? I think in this case, I think it can solve.

But I'm not sure that that's it. I think maybe there's something else that we need to look again. To solve this performance issue. But we need to compare before this release and before this release if the performance issue has become better or not. Okay so why going... if you're not convinced that this is necessarily the the right thing that maybe there's something else right?

So why going with basically creating new tables, new views, releasing that and then seeing the impact rather than going deeper in the investigation to figure out exactly what is the bottleneck?

I think we can like check, have a list of voice items that we can improve, and I think this is... One of the items that we can improve right now and easily and faster I think so the client can get the better performance. But later we need to investigate again for the root cause so that we can improve better.

Maybe an improvement but you're not sure yet. So why not doing the investigation first?

Currently, the client is moving a bit faster, so I think the investigation will need a longer time. And we already know that this item, we can improve this first. And we can achieve faster results right now. Okay, but you still run the risk of this not really solving the problem for your client, right?

Yeah, but I think we are not released this feature yet, so I want to like for this The budget that we have right now, for the time limit, is including how much percent better before we take the time to really invest into it. Do you know the actual queries that are being made? No.

For example, figuring out what are the queries here and starting to go measure the query time at the database level. good enough or do we have some querying problem i don't know n plus one problems or or whatever kind of thing that may slow down the queries right so that you can figure out okay do we have a database problem or is it something else right um why not why not taking taking it a push like this

I think what you said is maybe one thing that we can do. Okay, so I'll take the opportunity here to share. And also because I want to, however, you know, wherever possible, I like to share context on how we work, you know, at Nimble and what kind of things are expected from a technical product manager, right?

In a case like what you described, a technical product manager on our side, the expectation would be typically what I just outlined, right? It's like, if as a product manager, you realize that, okay, there's a problem, like this is too slow. There's a problem, even the clients are not super happy. The first thing that you should be doing as a technical product manager is figure out why is it slow. And figuring out why is it slow doesn't just mean asking engineers, hey, why is it slow? Because engineers sometimes, and I don't know how has been your experience transitioning from engineering to product.

And maybe some things will remind you of some younger days or not, I'm not sure, but you know, sometimes engineers, they will be looking at things without the whole context, or they may be looking at things in a silo, or they might be already starting to think about, okay, what can I do about it, but without necessarily having all the context to figure out what is the best way to approach it, right?

So from a technical product manager, for us, at least, our expectation would be that, okay, you need to figure it out, right? You need to know exactly why things are slow. And if it starts with, if there's a doubt, like, okay, maybe the database, our database structure is not optimal or something like that, the first thing would be, okay, figure out what are the queries, what's the SQL query that's being done here?

Go run that, figure out, can I get, or if I do that at the database level, are the results fast enough? So if the results you see are already slow here, it's like, okay, so now we have a querying problem. But actually, is it a querying problem because the queries are not built properly?

Or is it a querying problem because the structure is not... good enough and you need to maybe query and join too many tables and so on. Right. Then you can dive into that, but maybe your query is fast enough and now you can start thinking about, okay.

If the query is actually quite fast, then do we have like a processing problem, maybe on the back end, on the application back end, right? So this is what, as a technical PM at Nimble, that's what a technical PM will be doing, right? They will be diving in and this kind of investigation doesn't take a whole lot of time, right?

Once you figure out the SQL query, right? How much time does it take to log into the database, run a few tests, try some things out. I mean, within a couple of hours, you can kind of pinpoint already a pretty decent. area where the problem might be coming from. You might not know exactly what the bug is or the bug or the problem or whatever it is. But you should be able to get to a fairly good assessment within a couple of hours. Which means that at this point, then you can help drive your engineering team in the right decision.

Because maybe the answer is, okay, we need to create a read-only view of certain things. Maybe you figure out that the problem is actually much deeper. Maybe you need a read replica of your database directly because you have like some Some I.O. problem on the database. I don't know. This can be coming from so many things. So as a technical PM here at Nimble, that's kind of like the approach that would be expected. So that you figure out exactly, you know exactly what the problem is.

You can have the right conversation with engineers. You can share the right context with engineers as well to make sure that they are going to take the right path. And also when you end up talking with your stakeholders, with your clients, you'll So I have very clear what's going on, what the team is doing, like why it's happening, what's the team doing about it, right? Yeah, so what do you think about that? Does that make sense to you, or is this something that you can see a technical PM doing, or yeah, what are your thoughts?

Yeah, I get what your point is, like, the technical part of the video in the demo, like, we're really diving, like, um... We understand all of the credit that the Asian Region does. I think it's some length of what the Asian Regions live as well. I would say we still have all the roles in the team. So typical team on our side, you're going to have a product manager, you're going to have a couple of engineers, depending on project size. Typically, there's going to be an engineering lead as well.

That can be the point of reference for the highly technical, the most technical stuff. So we still have full teams with engineering leads and everything. But the difference here is that our product managers are very technical and they go deep. into problems, into solutioning. So we do still have engineering leads but that doesn't prevent PMs from actually doing all of that in-depth investigation.

I understood what your point is. Maybe I can ask you more from the engineering side of the engineering. Like what is the query and which part is the really root cause. Context is different. I don't know the dynamics in your current team, how things work. I'm not trying to say, hey, this is what you must be doing. Maybe things just work differently in your company. But what I want to do is to bring that clarity to you.

Also so that you have that clarity, right? To make sure that... If you join us here, you will be expected to do this kind of thing, right? So I want to make sure that you have that understanding as well, so that let's imagine that you end up joining us and one day this kind of things happen and you get surprised like, well, I need to do more, more investigation, I need to dive deeper.

So I want to share as much clarity as possible about expectations on the role, right? And yeah, just to make sure that that matches what you want to do, right? What you think a technical PM should be doing, what you picture the role doing. First of all, does it make sense to you? Is this something that you see yourself doing? Maybe not in your current company, if the context does not work for that, but do you see yourself doing this kind of work?

Yeah, actually because I don't really have much background, so I kind of like trust my engineer that they say that the root cause is the query, then okay, then solve it, then let's solve the query. But if I have much more context, then I can ask a more...

I think I can learn that as I go deeper and understand more about the back-end stuff. One thing that I want to clarify here is that, for me, it's not a matter of how much trust you have in the engineering team. I can tell, we have a very high level of trust across everyone on the team. And all of the engineers that we have are very competent people.

So we have a very high level of trust in general. But it's important to also realize that Product managers are the people with the most context, with the most understanding of everything that's going on, that have the context about technical things, about maybe more commercially oriented things. As a PM, you're the one with the most knowledge about client frustration.

Maybe, hey, could this have some sort of commercial impact? Now you have maybe a customer that is unhappy and you know they maybe have a risk of churn, right? Maybe you have context from internal stakeholders as well. Maybe there's like management team is feeling a certain way about certain things, right? And all of these things are important for decision making, right? But engineering teams, they often don't have all this context, right?

So even if you can, and you should, right, be able to trust your team from a technical standpoint, it doesn't always mean that they will be able to make the best decisions if they don't have all the context, right? So that's why it's also very important for PMs to do that.

work because it's actually just one more piece of context for them. Once you have the visibility on everything, what's going on with clients, what's going on commercially, what's going on with internal politics, what exactly is happening on the technical side, then you are in a perfect position to make the right decision.

And at the end of the day maybe you can say hey look in this case I need a quick patch. I know it's not a long-term fix but because of all this context that's what I need right now. now. Or maybe it's going to be a situation where the team comes back and says, hey, we can do a quick patch for this. And maybe in that context, you're going to tell them like, hey, look, I understand. I appreciate the suggestion. But right now, given the context, I don't need a quick patch.

We need to work right away on a long term solution. So see that there's many ways that something can be can be approached depending on the context. So that's one of the reasons why it's so important for us, at least. Right. That PMs can dig deep in every topic, whether it's technical, it's business, it's UX, right? Because then they can get all the context. They're gonna be the one person that has the context on everything and can then make the right decision.

Yeah, let me think. So, on the topic of performance, let's say that... In this case here that we were discussing, you said that you found it to be a little slow on the dashboard and all that already, right? Is this after a client reported a problem or when did you start thinking or feeling like maybe something's not right here?

Did you have customer complaints at this point or where were you in that journey? We got a customer complaint because the customer data is very big. It's not like what it has previously. And yeah, it kind of like a click for me that we need to like webcasting. We need a much more bigger data for the next release. So yeah, for this kind of issue right now, we need to fix it.

We really love all of the pieces. We really start finding the love for all of the pieces that we have. identified internally first. Yeah, I think we, I would like to say that we would miss that part, like we don't really have. We don't test that many data first at the first release. So, like what I said a little bit, I suggest you restart that.

We need to make it as ideal workflow for the next release. Yeah, because we mostly test the functional because that's what matters to us currently because we For the company, the first company, we don't really have that much data. But slowly, the company got bigger and bigger and had much more data.

Okay, so I think that's another point that I want to also highlight in terms of the expectations that we have on our side for a team is that this kind of problem is something that we

We expect our team to catch this kind of problem earlier on. In terms of data, I mean, it's pretty easy to just seed random data as well. So in terms of when it comes to testing and to making sure that everything works, I think it's important that everybody takes ownership on that as well and make sure that, okay, I test in a happy case, but what about unhappy case?

What if I have any... You work in the HRIS space, right? So HRIS, you're going to have so much data generated by clients, right? So it's important to also think about all of these unhappy case and think like, hey, what if I have a million records in the database? It's a company that's been doing payroll with our system and managing leaves for a few years.

They have millions of records. Can we generate this amount of data and test it out? So I think it's important So that people see that as being a potential kind of issue that could arise and to make sure that we proactively test for this kind of scenario as well.

So, you see now with a couple of these things shared, I'm kind of going back to one of the things I asked you earlier about what do you think about learning a lot and very quickly. I think that maybe you can maybe start to kind of like see a bit of a pattern here, which is that the way we work is way more intense than in a lot of other companies.

So I want to do my best to make that. very clear and evident for you so that you have the right understanding and you can make the right decisions for yourself as well. So now, if I actually go back a little bit to that question and given everything that we've discussed and that I shared about how we typically work in certain scenarios here, do you feel like this is something that you're interested in doing, that you'd be keen on taking a challenge like that?

I think I'll like, it doesn't describe the details, but what I want to ask is like, when you mean like a lot of... Yeah, it's a good question. Let me think about a good example to to share Okay, let's say for example Let's talk about performance and like not specifically like the case that that you shared right that you had let's just talk about performance in general because Performance is a big topic

There can be a million different things that will impact performance, but at the end of the day, the problem is still the same. When you have poor performance, now things don't work well, right? So if we talk, let's think about performance, for example.

Now, let's say that, Let's say that you're the product manager on a client-facing application, let's say maybe e-commerce application, and we start to see that the performance is not great. Things are a little bit too slow, and let's say it's in the context of an e-commerce website, so you're selling, you're live on production, you're selling.

And performance is becoming a bit of a bit of an issue very clearly in the e-commerce space. Performance has a very big impact also on conversion rates. So it's so it's pretty critical, right? It's pretty critical and Let's say that you look into the problem, collaborate with the team, figure out that

OK, actually, to fix the performance problem, it's a fairly involved process. Yeah, we probably need to do some intensive work. I don't know, maybe that's even like creating read replica of the database to feed dashboards so that you can free up some of the bandwidth for transactions.

So in a context like this, given that it's a big problem, impact on conversion rates, it's e-commerce, but doing the real fix is going to be somewhat significant in terms of effort. So with this context, which way would you rather go? Say, okay, let's just take the time and fix this thing properly, or would you rather go, all right, let's do a quick, let's try a quick, quick fix.

First, and then we spend time on maybe doing deeper work. So what would you, which direction would you choose?

Thank you for watching.

Maybe I will assess this like, what's the current impact right now? Is it really slow that the user can't access it at all? Or is it slow but we can't tolerate it? For bigger data, it will be unfoldable anymore. And then, that's all there. Talk about the importance of context right to answer your question. So in this context here, let's say that yeah The the application is still usable, right? But yeah, like for example, you see that the checkout page

Takes maybe like sometimes like a couple of seconds to load. All right. So if like that's the kind of impact that you're seeing. So what would you do then?

If it's a couple of seconds, I think it's quite slow for me. So I think if there is any criticism, you can go first. I think we can do the paper first, but on the other hand, we're still doing a deeper analysis investigation on the real-world cause, and we can take more time.

If there is a significant effort that we need to take to resolve the performance issue. Because now what you're seeing is that, oh, we probably losing sales here, right? Because my conversion rate is going to be impacted. All right. So we're probably losing sales.

But now, let me add one more piece of context. Let's say that, hey, the marketing team has committed. We're going to be doing a TV commercial in two weeks. Does that change your decision?

like we need to doesn't we cannot just fix this issue but we need to like spend much time to really solve this issue before these two weeks Yeah, so you see now, the context has changed. So your decision has changed. So that's why, you know, when I talk about context, the importance of context, that's what I mean, right?

And there's going to be, when we talk about context, there's going to be a lot more subtle things right here. We talk about big, big things, right? But there can be a lot more subtle things that the engineering team is not necessarily going to be aware of, but that you as a product manager will know about, right?

And these things, whether it's like a big thing or like a subtle nuance in the context, These are the things that will drive your decisions.

So does that answer your question? Yeah, yeah. Yeah, that answers my question. Okay. All right. So I think for me, that's going to be about it today in terms of all the questions and things I wanted to go through. So thank you very much for going through all of this with me.

I'm not sure if you have any other questions. If there's anything at all that you wanna ask or discuss, I can spare a few more minutes. I'm happy to answer anything that you may have. I have a couple of questions. I want to understand more. How do you measure punctuation?

So how do we measure what part exactly? How do you measure the success of a new product? The easy part of the answer is the expectations is that a product manager will be able to independently drive the product. The hard part of the answer is that it can mean so many things. If we talk about just a few of these things, it means...

Being able to get things done on time, right on time, meaning like as per committed timelines, right? Being able to get things done with the right level of quality. All right, being able to get things done with the right level of performance as well. All right, so getting it done, it's not because you put something out.

And it's like, okay, you can log in, and you can maybe make a purchase, right? That it's necessarily successful. Because, yeah, if the performance is bad, your conversion rate's gonna be bad. That's bad for the client, so. There's all of these nuances are things that we factor in. So for us a successful product manager is somebody who can take that ownership on a product, right? So I think that the keyword here is that ownership meaning.

That you can drive the product development, the product delivery. But the ownership part means that we expect to see people who are deeply involved and deeply aware and careful with the quality, with the performance, making sure that we deliver the best product that we can, right? So if there are some performance, anything that you see, for example, the team delivers, you know, but like, you're like, ah, the performance.

It's not that great what's going on, like the website is a little bit slow, right? Why? Then dig into it, figure out what's the problem, get it fixed, right? And that's the kind of mindset that we expect to see and that's how we measure success for new product managers.

It's going to be somebody who can make progress with the right mindset and with the right sense of ownership. Does that make sense? I would like to know if Stimple has an internal project or just only the client project. Usually our clients are more enterprise-sized, so pretty large companies, and we also have an internal product. So that's something that we've been developing for about a year, year and a half at this point.

And that is in production, that is being used by a number of customers. So mostly in the in the QSR space, QSR, so that's quick service restaurants. So our product is basically it's a SAS that It powers basically restaurant chains in a lot of different ways, from e-commerce to POS to self-ordering kiosks to order management.

to kitchen display systems, so cover basically kind of like end-to-end how to run a restaurant chain. This product is live, it's currently powering around 1,500 stores in a few different countries. So that's something that is also growing in the company, that we're developing more and more. So the bulk of what we do is still services, but we also have this product internally.

Maybe what is in front of you, like, why do you create this internal project for them? Because there's a need for it. It's a simple and yet not so simple answer. Because we've built other products before. And it didn't work. I think we've done it like maybe two times, right? We created some products, we ended up killing them because we just...

It didn't sell and at the end of the day, the reason why is because there was not a strong need for it, right? So with the product that we have now, we have completely changed how we do things in terms of product development internally, in terms of building products internally.

And this product, we've built it because there's a need. And actually, it's even more than that. We actually sold the product before we built it. So that's just to show how big a need there is. We've been working more and more within the QSR and FNB industry in the past couple of years.

And we have seen this as an emerging. We have seen the same problems over and over and over in many companies. And all these companies struggling very hard to solve these problems. So this is where we figured that, hey, Not only we can solve these problems, we've solved these problems in the past with just development of custom solutions for clients. But we reached the point where we can just productize this and solve these problems at scale.

So that's the reason why we've built this product.

So what I understand the product is like the restaurant chain management, is that correct? Correct, yes. So maybe if I'm a new client that has... I can use that like the ready product, the legal password, instead of loading my customer log.

I think that's all my question. Like I said at the beginning, next thing is that I'll be debriefing with our talent acquisition team and then you should expect to hear back from us sometime later this week. Alright, thank you very much for your time and have a good day. Thank you.