---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2021-01-21
---

# Backlog Management

# Backlog Management

Standardizing the backlog management is essential for maintaining clear and highly actionable backlogs. It also allows any Product Manager in the team to understand any project's backlog with little effort.

Without standardization, it becomes extremely difficult and time consuming for a Product Manager to understand how a backlog is organized, let alone how the product needs to be developed.

## Organization

Depending on the project and the client requirements we might use different tools for backlog management.

Regardless of the tool, the way we organize the backlog revolves around the same concepts. Only their representation varies to adapt to the capabilities of the tool used.

### Modules

Modules represent the main components of an application. They are the smallest denominator to which an application can be reduced. Each module contains several features.

For example, most application will need an "Authentication" module which will regroup all login and registration features.

In fact, there are several modules that are usually common to most applications: Application (the most generic module in an application), Authentication, and User Profile.

#### Naming

Module names should be as short and accurate as possible. There is no specific pattern for it and it is up to the Product Manager to identify names that fit this ideology best.

Here are a couple of examples for the sake of illustrating this ideology:

- Authentication, for an authentication module.
- CRM, for a Customer Relationship Management module.
- Payment, for a payment gateway module.
- Push Notifications, for a push notifications management module.

##### Slug

Modules, in addition to having a name, might also need a slug for use in labels. The slug is a shorter, more condensed form of the name. Given how short module names are, the slug is typically a hyphened version of the name. For example:

- Authentication: `authentication`.
- CRM: `crm`.
- Payment: `payment`.
- Push Notifications: `push-notifications`.

### Features

Features are coherent and standalone groups of user stories that define functionality in the application. A feature must belong to one and only one module (there is a hierarchical relationship between the two).

```jsx
Module
└── Feature
```

> A feature must be the smallest standalone piece of software which brings business value.
> 

For example, "Login with email and password" is a feature belonging to the "Authentication" module. So is "Login with Facebook" (for application that support it).

As the examples above show, features are small and standalone. Others might encompass both login with email and login with Facebook as one feature. However, such an approach forces the Engineering team to deliver both for the feature to be complete.

In reality, if the "Login with email and password" feature is ready but "Login with Facebook" isn't, the former can still be released as a working, standalone feature to a production environment. It is the reason why a feature must be the smallest standalone piece of software which brings business value.

#### Naming

The naming for all features should follow a pattern that is somewhat similar to the user stories but in a shorter form.

The naming pattern, whenever possible, must be `<user> <requirement> <action> <item>` where:

- `<action>` should be one of: list, view, create, delete.
- `<requirement>` should be one of: can, must.

For example:

- User can list tickets
- Admin can view ticket details
- Agent can create ticket
- Agent must assign ticket
- Admin can delete ticket

The above examples are very [CRUD](https://www.codecademy.com/articles/what-is-crud)-like. Not all features can be described using this exact format but Product Managers should strive to follow this pattern as much as possible.

When following this pattern is not possible, feature names should always be descriptive. Generic feature names are frowned upon. For example, if a login feature needs improvement, creating a feature named "Improve login" is virtually useless as it doesn't describe the update. Moreover, when multiple iterative improvements are being made to a feature a name such as "Improve login" becomes useless *and* confusing.

Instead, be descriptive. If the login feature needs to receive field validation then the feature should be named "User can see live validation when logging in." This name is descriptive and helps understand the feature at a glance.

##### Slug

Features, in addition to having a name, might also need a slug for use in labels. The slug is a shorter, more condensed form of the name.

When feature names can follow the recommended pattern, the slug pattern is `<user>-<action>-<item>`. For example:

- User can list tickets: `user-list-tickets`
- Admin can view ticket details: `admin-view-ticket-details`
- Agent can create ticket: `agent-create-ticket`
- Agent must assign ticket: `agent-assign-ticket`
- Admin can delete ticket: `admin-delete-ticket`

When a feature name can't follow the recommended pattern, its slug should follow the same ideology being short and condensed. For example: `user-login-live-validation`.

### Versions

Versioning software is a basic principle (this very documentation is versioned on Github). In the backlog, each user story must be associated with a released version to facilitate tracking and debugging.

Versions are identified by the label `@x.x.x` where `x.x.x` is the actual version number. For example, all user stories released as part of version 1.2.2 must have the label `@1.2.2`.

### User Story Types

We use three types of user stories even if a given backlog management tool offers more (or customizable) types: "User Story" (called "Feature" in some tools), "Bug", and "Chore."

### Labels

Labels (or tags) are heavily used in our backlogs. They help represent the backlog's organization (with variations between backlog management tools) and any other sort of data visualization. It is important to use labels (there is no overuse) whenever something important needs to be tracked or presented.

For example, should there be a Request For Change for a product, the associated user stories should be labeled with the RFC number following the format `rfc-<number>`.

While there are a number of standardized labels, all labels don't have to be standardized. It is at the Product Manager's discretion to create and maintain relevant labels in their backlogs.

#### Standard Labels

There are a handful of standardized labels that are used throughout most backlog management tools.

- Module label. Its pattern is `#<module-name>`. Example: `#authentication`.
- Feature label. Its pattern is `$<feature-name>`. Example: `$user-list-tickets`.
- Chore label. Its pattern is `!<chore-name>`. Example: `!setup-ci-cd`.
- Version label. Its pattern is `@<semver>`. Example: `@1.2.2`.

<aside>
💡 Those standardized labels are not necessary with every backlog management tool but, when they are necessary, they must follow the above patterns.

</aside>

#### Format

The standardized labels are prefixed with a symbol (e.g., `#` or `$`). Non-standardized labels **must not** be prefixed by any symbol.

The use of a symbol for the standardized labels allows for better sorting.

For example, when sorted alphabetically (a default in most tools), the modules `authentication` and `user-profile` would likely not be listed consecutively. Other labels would likely be in the middle.

Using a symbol forces the standardized labels to be listed consecutively. In the example above, `#authentication` and `#user-profile` will appear with all other module labels without others in-between.

#### Initial Label

As all projects must start with an exhaustive backlog, all the initial user stories must be labeled `initial-scope`. It will help later on with differentiating the initial project scope and the changes that made their way into the backlog and to the product. This label will give a snapshot of the project at its early stage.

### Workflow

Taking a user story from "new" to "completed" requires going through a few specific steps. Our implementation workflow has five steps:

- **Ready for development:** the user story has been scheduled and developers can pick it up and start implementing it.
- **In development:** a developer has picked up the user story and is currently working on it.
- **In code review:** the developer finished the implementation and the code is being reviewed by peers.
- **Ready for QA:** the code has been successfully reviewed and was accepted requiring a round of manual Quality Assurance (QA).
- **Completed:** Quality Assurance has been done and the user story was deemed complete and finished.

<aside>
💡 If Quality Assurance fails, the user story is moved back to "In development" with a comment detailing why QA did not pass.

</aside>

- Tools
    
    ### Pivotal Tracker
    
    ### Clubhouse
    
    ### JIRA
    

## User Stories

*Current content from backlog management.*

## Grooming

While some companies do grooming or refinement meetings where they review and refine their user stories, we don't at Nimble.

The backlog grooming and refinement happens on a continuous basis. Product Managers constantly review, organize, and prioritize their backlog.

When new user stories are needed (e.g., new feature), Product Managers write the entire backlog from the start. Given the technical skillset of Product Managers at Nimble, the user stories are detailed and technical wherever necessary.

As soon as new user stories are ready, the Engineering team comes into play. They review and estimate all new user stories (and provide feedback if needed).

This mix of continuous grooming, technical skillset, and early involvement of the Engineering team removes the need for dedicated refinement meetings.

![](Backlog%20Management/backlog-grooming-cycle.png)