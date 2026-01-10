---
type: resource
created: 2026-01-10
status: active
tags:
  - career
  - project-management
  - training-path
  - self-improvement
related:
  - "[[Antho’s Training Path]]"
  - "[[Create a course to become a Technical Product Manager]]"
migrated_from: notion
migrated_at: 2026-01-10
---

# Technical Project Manager Training Path


# Intro

The following is a training path about product development. It is not meant to be comprehensive by any means, and it relies heavily on external resources. Think of it as a summary of the most useful and qualitative resources that I know are available on the web.

This training path intends to accomplish the following goals:

1. Establish some core terminology.
2. Outline various methodologies used in software development.
3. Trace the high-level lifecycle of a product (in the context of a service company.)
4. Explain how to build products **focusing on quality**.

# Product Development

<aside>
💡 Note that the entire training path was designed from an Agile perspective.

</aside>

## Product Development Methodologies

### Waterfall

Waterfall is “the old way” of building digital products. It is a similar methodology as used in the construction industry. There are hard requirements for each step to be taken in a specific order, at a specific time.

### Agile

Agile is an iterative way of building products. It aims at creating products that can adapt to their market and customers quickly.

<aside>
💡 Agile is commonly accepted as the superior way to build successful digital products nowadays.

</aside>

- [ ]  [What is Agile Software Development? | Agile Alliance](https://www.agilealliance.org/agile101/)

## Kicking Off

In the context of this training path, kickoff is slightly different from an actual project kickoff. We’re going to back things up a bit more than we normally would.

### Selecting the Stack

Selecting the stack typically depends on two things:

- The team’s expertise in certain stacks.
- The project requirements (not all technology stacks are suited to all use-cases.)
- [ ]  [What is a Tech Stack? Choosing What Goes In Yours](https://heap.io/topics/what-is-a-tech-stack)
- [ ]  [Choosing the Right Tech Stack for Your Project: Basic Principles](https://www.velvetech.com/blog/choosing-project-tech-stack-basic-principles/)

### Setting Up the Tools

Setting up the tools might sound simplistic but it is essential to set up *everything* that you’ll need to lead the project. To do so, you need to have already identified what tools will be needed.

There can be a dozen tools will be needed in various categories:

- Communication
    - Email groups
    - Instant messaging solution (e.g., Slack)
- Product Management
    - Backlog management (e.g., Shortcut, JIRA)
- Design (e.g., Figma)
- Development
    - Git repositories (e.g., Github)
    - CI/CD pipelines (e.g., Github Actions)
    - Builds distribution
        - Development and staging (e.g., Firebase)
        - Production (App Store, Play Store)

## Preparing

### Gathering the Requirements

Requirements gathering is a crucial and demanding part of a project. A Product Manager or Business Analyst will usually run project discovery to understand what is the expected outcome, who are the users, what is the industry, what is the competitive landscape, what is the market, what features are needed, how the features should work...

- [ ]  [A Guide to Requirements Gathering](https://www.wrike.com/blog/requirements-gathering-guide/#Are-there-best-practices-for-requirement-gathering-techniques)
- [ ]  [Product Requirements Management | Definition and Overview](https://www.productplan.com/glossary/product-requirements-management/)
- [ ]  [What Is a Product Requirements Document (PRD)?](https://www.productplan.com/glossary/product-requirements-document/)

### Documenting

Documenting features, workflows, logic, and specifications is an important part of the product development process. Writing good documentation requires experience and an organized mind. There are a few things that can be learnt to write better technical documentation, and to write better in general.

- [ ]  Start using [Grammarly](https://www.grammarly.com/)
- [ ]  [Technical Writing One introduction](https://developers.google.com/tech-writing/one)
- [ ]  [Technical Writing Two introduction](https://developers.google.com/tech-writing/two)

### Building the Backlog

With the (initial) requirements gathered and the tech stack defined it is time to start preparing the product backlog.

- **Writing the epics** to break the product down into small yet functional pieces that can be built individually.
    - [ ]  [What is an Epic in Agile?](https://www.productplan.com/glossary/epic/)
- **Writing the user stories** that Engineers will use to *actually* build the product and its functions.
    - [ ]  [User Stories](https://www.atlassian.com/agile/project-management/user-stories)
- **Prioritizing the epics and user stories** in a way that makes product and business sense (based on business value, development efforts and other criteria depending on your prioritization framework).
    - [ ]  [Product Prioritization Frameworks: The 9 Most Popular](https://roadmunk.com/guides/product-prioritization-techniques-product-managers/)
- **Scheduling sprints** to get the team to work on building the product.
    - [ ]  [Sprint | Agile Product Management](https://www.productplan.com/glossary/sprint/)

### Scheduling Agile Ceremonies

Another important step of the preparation process is to schedule all the important and *recurring* agile ceremonies: sprint planning, sprint review, retrospective, daily stand-up.

- [ ]  [Four agile ceremonies, demystified](https://www.atlassian.com/agile/scrum/ceremonies)

## Building

### Starting and Ending Sprints

Building software, in agile methodology, is done iteratively in “sprints.” A sprint is a time-boxed (commonly 2-weeks) iteration where new code is added. The goal of a sprint is to produce a fully functioning version of the product including new features, improvements, and bugfixes by the end of the time box.

Before each sprint starts, the team gathers for a sprint planning session where the contents of the upcoming sprint are discussed.

- [ ]  [What is Sprint Planning?](https://www.productplan.com/glossary/sprint-planning/)
- [ ]  [Sprint Goal](https://www.productplan.com/glossary/sprint-goal/)

When the sprint ends, the Product Manager usually conducts a sprint review where the achievements of the sprint are demonstrated to the product’s stakeholders.

### Writing Code and Reviewing It

During the sprint, the Engineers pick up the user stories scheduled for that sprint one by one and write the code necessary to produce the expected outcome for each story.

The process to achieve the outcome is:

1. An Engineer writes tests (when TDD is employed)
2. The Engineer writes the code
3. The Engineer opens a pull request
4. The teammates review the code and comment
5. The author of the code processes the comments and makes changes
6. The teammates approve the pull request
7. The code is merged into the development branch

The Engineer then picks up the next user story and repeats the process until the end of the  sprint.

- [ ]  [Why code reviews matter (and actually save time!)](https://www.atlassian.com/agile/software-development/code-reviews)

### Testing the Code and Features

Once new code is merged into the main product’s codebase (the last step from the previous section) the updated codebase needs to be automatically tested and the updated application *also* needs to be manually tested from the user’s perspective.

Manual testing should be done by the Product Owner and, when the product size and usage justifies it, by an entire Quality Assurance team.

All the testing can result in two things:

- The rejection of a user story if it doesn’t pass the acceptance criteria (typically done by the Product Owner).
- The creation of bug reports. Bug reports will then need to be investigated, confirmed, and prioritized based on their severity.

## Delivering

### Quality Assurance & Environments

An application needs to be delivered often and in different environments.

The most common environments used are:

- Staging, used for testing the application before putting it in the hands of its users.
- Production, which is the “live” version of the application used by actual users.

The application is delivered many times a day to staging and once at the end of every sprint to production (or depending on the company’s release schedule.)

### CI/CD

Delivering (or “deploying”) the application to the various environments is done through a process known as “CI/CD.”

CI/CD (Continuous Integration/Continuous Deployment) is an automated pipeline consisting of multiple steps. The most common of those steps are:

- Continuous Integration (CI)
    - Automatically testing the codebase.
    - If the automatic tests pass, build the application to its final, functional form (to be used by human users)
- Continuous Deployment (CD)
    - Deploy the functional application to the appropriate environment (staging or production)

The deployment will be done to a web server for a web application and to a distribution tool for mobile applications (e.g., [Firebase](https://firebase.google.com/)) *or* directly to the App Store (iOS) and Play Store (Android) for production deployments.

- [ ]  [CI/CD concepts](https://docs.gitlab.com/ee/ci/introduction/)

<aside>
💡 CI/CD is an essential part of the agile process. It allows for testing an application quickly and often which results is less bugs and surprises after production releases.

</aside>

### Versioning

Deploying an application to its production (i.e., “live”) environment is referred to as “releasing.”

What is being released is, of course, the application build (the compiled codebase) but *specifically* it is a precise version of it.

When a new release is needed, the team will tag the codebase at a very precise point in time and attribute a version number (e.g., 1.0.0). A release is always the deployment of a specific version of the code to the production environment.

With this versioning process, is becomes very easy to roll back to an older version in case of problem.

For example, let’s assume that the team just finished working on version 1.6.0 of their application and 1.6.0 is released to production. Let’s also assume that a critical bug is then reported by the application’s users.

The team can very easily roll back to a known working state of the code because they can just pick any past version. The team could, for example, roll back to version 1.5.0 in a matter of minutes while they work on fixing the bugs in version 1.6.0.

- [ ]  [Semantic Versioning 2.0.0](https://semver.org/)

## Iterating

Iterating is a central piece of Agile methodologies. Each iteration repeats 3 of the above steps: preparing, building, and delivering.

Building products iteratively allows for a fast time to market (no need to wait for “everything to be finished”) and for reacting to external forces and factors quickly (product-market fit, customers feedback, industry pivot...)

# Software Development

Software Development, in the context of this training path, is separate from Product Development. While both are required to deliver a product, product development is focused on *building the right* product, and software development is focused on *building the product right*. The difference is subtle yet essential.

## The Basics

### What & Where

Software is found anywhere. In fact, you’re using software all day long whether you know it or not.

When using your phone you’re using dozens of software: the Operating System (iOS, Android), the apps that you installed. The keycard system you use to enter your condo has a software.

But you’re also using software in places you might not suspect. Your car has a software. (Even more so in modern cars like Teslas which are *heavily* software-driven and can be updated remotely.) Your smart fridge has software (basically any “smart” appliance has a software.) Your TV has a software.

### Types of Applications

There is no official categorization of the types of applications that exist but there are X broad categories that can help understand the purpose of an application, its logic, and complexity.

- **Client applications.**
Client applications are apps that don’t have an internal business logic and, instead, rely on a server application that provides the necessary logic. Most mobile applications are client applications that rely on a remote server for their business logic and data storage.
- **Server applications.**
Server applications are typically (but not always) for machines and not for humans. There is no graphical interface. Instead, the application has an internal business logic that defines how client applications (those destined to be used by humans) need to behave and function.
    - [ ]  [What do client side and server side mean? | Client side vs. server side](https://www.cloudflare.com/learning/serverless/glossary/client-side-vs-server-side/)
- **Monolithic applications.**
Monolithic applications are apps where everything is built-in: client and server. There is only one application that handles the business logic, data storage, and graphical interface.
    - [ ]  [Introduction to Monolithic Architecture and MicroServices Architecture](https://medium.com/koderlabs/introduction-to-monolithic-architecture-and-microservices-architecture-b211a5955c63)
- **APIs.**
API applications (APIs can be standalone applications but they are usually built in a server application or a monolithic application) offer an interface for a client application to communicate with a server application. It’s the bridge between the two.
    - [ ]  [What's an API?](https://technically.substack.com/p/whats-an-api)

### Databases

Databases are important because they are both a technical component (i.e., creating and managing databases is part of an Engineer’s work) and a product component because it needs to store all the information necessary for the product and all the user-generated content.

Because the information architecture (i.e., how the data is presented and used in an application) of a product is an important part of what *defines* the product, data architecture (i.e., how the data is stored in a database) is a direct representation of the product itself.

- [ ]  [Introduction to Relational Databases](https://mariadb.com/kb/en/introduction-to-relational-databases/)
- [ ]  [SQL Tutorial](https://www.w3schools.com/sql/)

## Tools & Workflows

### Development

There are so many tools that are used by Engineers for the purpose of developing a software. For now, we will simply look at *some* (it would be impossible to list them all) of the most basic yet fundamental frameworks.

<aside>
💡 Frameworks are a sort of template for different programming languages. Those frameworks contain commonly used components, pre-built helper functions, and more. The objective is to enable Engineers to develop faster by not having to re-create the same thing many times over.

</aside>

- Backend
    - [Ruby of Rails](https://rubyonrails.org/) for the Rails language
    - [Laravel](https://laravel.com/) for the [PHP](https://www.php.net/) language
- Frontent
    - [React](https://reactjs.org/) for the JavaScript language
    - [Vue.js](https://vuejs.org/) for the JavaScript language

### Version Control

Version control systems (VCS) are used to keep track of every single change that has been made to an applications’ codebase. It works on the same premise as version history in Word of Google Docs with three massive differences:

- Every single change is documented through “commits” where the author of the change will set a message explaining what was done, why, and usually reference a user story detailing the work that needed to be done.
- VCS allow for collaborative work where each collaborator can incorporate their changes (a process knows as “merging”) into the main codebase.
- VCS are substantially more powerful than a version history system because they allow for different branches (i.e., different history paths) which can be worked on in parallel.

There are two main VCS on the market: [Git](https://git-scm.com/) and [SVN](https://subversion.apache.org/). Without getting into details, Git is the commonly used VCS with all modern software development.

Git is a system client-server system. Developers have the Git client installed on their machine and they push their code, commits, and branches to a Git server.

A Git server can be setup on any given server (cloud or local) but there are three major Saas providing Git server as a service:

- [Github](https://github.com/)
- [Bitbucket](https://bitbucket.org/product)
- [Gitlab](https://about.gitlab.com/)

There are many others but those three are the biggest and most popular ones.

- [ ]  [What is version control?](https://git-scm.com/video/what-is-version-control)
- [ ]  [What is git?](https://git-scm.com/video/what-is-git)
- [ ]  [Git Real](https://www.pluralsight.com/courses/code-school-git-real)
- [ ]  [Using git-flow](https://jeffkreeftmeijer.com/git-flow/)

## Testing

Testing is a must for teams wanting to deliver high-quality software. There are many ways to test an application and there are many different types of testing.

### Types of Tests

During the development cycle, there are a number of types of tests that can and should be run (depending on the project scope and, typically, the audience of the application.)

The various types of tests are commonly represented by the [“testing pyramid.”](https://martinfowler.com/articles/practical-test-pyramid.html)

![Untitled](../../Projects/Antho%E2%80%99s%20Training%20Path/Untitled.png)

- [ ]  [The 3 tiers of the Android test pyramid](https://medium.com/android-testing-daily/the-3-tiers-of-the-android-test-pyramid-c1211b359acd)

### Automated and Manual Testing

The tests represented in the previous section are usually run automatically as part of the CI/CD pipeline. Automated tests are a great way to prevent regressions (i.e., breaking a functional part of the application while adding a new feature or making changes in the codebase). Automated tests can and should be run every time a developer commits new changes to the VCS.

Manual tests, on the other hand, are meant to test an application in a variety of different scenarios, including scenarios in which the app was never meant to be used. Manual testing (usually performed by a Quality Assurance team) are also aiming at testing the app with a wide variety of devices in order to catch device or OS version-specific issues and bugs.

- [ ]  [Manual Testing for Beginners](https://www.browserstack.com/guide/manual-testing-tutorial)
- [ ]  [Manual testing - what is it?](https://www.globalapptesting.com/manual-testing-best-practices)

### Test-Driven Development

In the world of software development, Test-Driven Development (TDD) is a method where Engineers *write unit tests before writing actual functions.*

The process is as follows:

1. Define the expected outcome for a feature.
2. Write a test that verifies that the function’s output is as expected.
3. Write the actual function.

This approach is more time-consuming but it is highly effective because it provides immediate feedback to Engineers about whether the functions that they write do, indeed, deliver the output that’s expected for the user-facing feature to work.

- [ ]  [Testing Software: What is TDD?. A Practical Introduction with Q&A](https://medium.com/javascript-scene/testing-software-what-is-tdd-459b2145405c)

## Common Components

The majority of all application share a few common components (even if they are implemented in different ways or using different frameworks.)

### Authentication

Authentication is the process of identifying whether an application user has the “right to enter.” Think of it as being on the guest list (or not) for a private event. If you are on the guest list, you are authenticated. The organizer knows who you are and is allowing you to enter the lobby (enter the application.)

### Authorization

Authorization comes after authentication. Once you have been identified and allowed into the lobby (authenticated), your level of authorization will define *where* you are allowed to go and *what* you are allowed to do.

For example, in your favorite social media application, given that you have an account, you can authenticate (log into your account) and you will be able to see and edit your own profile (authorization.)

You are also authorized to see your friends profiles but you are *not* authorized to edit anyone’s profile except yours.

- [ ]  [Authentication vs. Authorization](https://auth0.com/docs/get-started/identity-fundamentals/authentication-and-authorization)
- [ ]  [Difference between Authentication and Authorization](https://www.sailpoint.com/identity-library/difference-between-authentication-and-authorization/)

### IDM

- [ ]  [What is Identity Management?](https://www.vmware.com/topics/glossary/content/identity-management.html)
- [ ]  [The Difference Between Web Access Management and Identity Management](https://auth0.com/blog/the-difference-between-wam-and-idm/#What-Is-Identity-Management--IdM--)
*You can focus on the IDM section exclusively.*

### OAuth2

[OAuth2](https://oauth.net/2/) is a framework (in fact it is the industry standard) for authorization. Any application that provides an open API for other apps to interact *and* that supports OAuth2 allows for pretty much out-of-the-box integration with their IDM. 

# Infrastructure

Infrastructure is the central part of any application whether client or server. Infrastructure is where the core of the systems and the data lives (e.g., a server-side application, databases, APIs).

The quality of an infrastructure defines the application(s) reliability, load handling capacity, and security.

With modern-day software development, infrastructure is usually managed by DevOps Engineers.

- [ ]  [What's DevOps?](https://technically.substack.com/p/whats-devops)

## Cloud Computing

Cloud computing is the predominant way to create and manage infrastructure. The days of companies owning their hardware and running web services (e.g., websites, APIs) internally on their servers are long gone. It is much more practical and economical to rely on cloud computing instead.

- [ ]  [What's cloud?](https://technically.substack.com/p/whats-cloud)
- [ ]  [AWS for the rest of us](https://technically.dev/posts/aws-for-the-rest-of-us)

### Infrastructure as Code (IaC)

Traditionally, deploying infrastructure has been done manually by an Engineer. The Engineer would log into the cloud computing provider console (e.g., AWS), select the services needed, and configure them.

Doing so it time-consuming but, more importantly, it is error-prone. It is also hard to replicate (i.e., creating the same infrastructure multiple times) which is necessary for spinning up multiple environments (e.g., staging, production) or for Disaster Recovery Plans (DRP) where an entire infrastructure needs to be re-created following a disaster.

- [ ]  [What is infrastructure as code and why is it important?](https://www.hashicorp.com/resources/what-is-infrastructure-as-code)
