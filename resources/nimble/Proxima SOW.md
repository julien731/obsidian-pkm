---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2025-07-07
---

# Proxima SOW

# Instructions

You are a Senior Product Engineer as defined at the links below:

- [https://www.indeed.com/career-advice/finding-a-job/what-is-product-software-engineer](https://www.indeed.com/career-advice/finding-a-job/what-is-product-software-engineer)
- [https://productengineer.org/](https://productengineer.org/)

You must act as a Senior Product Engineer with very 10+ years of experience. Your objective for this project is to work with me, the Product Manager, to build the web application described in this document from scratch.

I will provide a brand new Github repository with a freshly scaffolded Rails application. It contains nothing more than what’s out of the box with Rails. The application is already Dockerized.

Building an entire application is a sizable endeavour and you must not try to build it in one go. Instead, I have broken down the application in a number of features and I want you to tackle those features one by one. There should be one PR per user story at least, more if needed.

One of the key pieces of this scope of work document is the ERD provided at the end. You must use this ERD to understand how the application should be build and use it in combination with the rest of the content, including the user stories and the permissions matrix, to build the application.

- If you are ever unsure about a feature or a user story, ask.
- If you think that a particular feature can be built in a better way than what’s described in the user stories or in the ERD, ask.
- You must write tests for each feature that you build. In fact, you must follow a TDD approach and write tests evaluating the expected outcome before even writing the code for the feature.
- The user stories provided are NOT comprehensive. The ERD shows a number of self-explanatory features through the data relationships. The user stories are only here to highlight certain aspects that aren’t visible in the ERD.
- **Always provide a plan before making any changes for new features, bugfixes, and improvements.**
- Plans should include questions, if any, concerns, compromises, and any other information useful to the Product Manager for making decisions.

Before we start working on actual features, you must:

- Assess the entire scope of work (including the `.sql` file) and provide feedback:
    - What’s good,
    - What needs to be improved,
    - What can create risks.
- Highlight any gaps or discrepancies between the ERD and the user stories.
- Provide an overall project plan.
- We iterate together on the final plan.

# Introduction

You are the Product Engineer for Proxima

Proxima is a web application built for consulting companies that need to track people’s assignments over long periods of time (as opposed to daily clocking in and out) and who bill the people’s time every month to their clients based on a given rate card.

Proxima is not designed as an HIRS but it must track some information typically managed in an HRIS and required to track and bill people’s time such as time off, project assignments, people, working locations, teams, and more.

# Objectives

- Provide traceability on people’s assignments over time.
- Provide a view of resources utilizations to ensure maximum billing.
- Provide a view of unassigned resources make it easy for the sales team to konw the available capacity.
- Provide timesheets at the end of each month that can be used to bill clients per project.

# Challenges

- Tracking projects that don’t have an exact end date (typically time & materials projects).

# High-level Modules

- Configuration
    - Positions
    - Countries
    - Offices
    - Currencies
- People
    - Teams
    - Assignments
- Clients
    - Projects
        - Project Teams
- Rate Cards
- Reports

## Non-functional Requirements

- The minimum billable unit is 1 man-day.
- Use Devise for authentication.
- Use Tailwind and https://github.com/TailAdmin/tailadmin-free-tailwind-dashboard-template for the admin dashboard.
- All destroy actions are soft-delete. No hard deletes.

# User Stories

[[Proxima User Stories]]

## People

- Admin can CRUD members
- Admin can CRUD teams
- When creating a new member, admin must assign the member to a team
- When creating a new member, admin must assign a position to the member
- When creating a new member, admin must assign the member to an office
- When creating a new member, admin can decide to also create a user for that member (with the role `member` by default)

## Holidays & Time Off

- Admin can CRUD holidays
- Admin can CRUD holiday calendars
- Admin can create a time off for a member

## Clients

- Admin can CRUD clients

## Rates

- Admin can CRUD rate cards
- Admin can CRUD rates

## Projects

- Admin can CRUD projects
- Admin can assign members to a project team

## Reports

- Admin can generate a report of worked time for a given date range and a given project team. The report should include all working days and, for each member, exclude their time off as well as the holidays associated with the office where the member works

## API

There will be integrations with this application and an API is needed. The API must support the following:

- Third-parties can create a new holiday.
- Third-parties can edit a holiday.
- Third-parties can delete a holiday.
- Third-parties can create a new time off.
- Third-parties can edit a time off.
- Third-parties can delete a time off.

# Permissions Matrix

# ERD