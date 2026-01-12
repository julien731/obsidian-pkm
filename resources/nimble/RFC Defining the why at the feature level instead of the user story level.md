---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2022-07-20
---

# RFC: Defining the "why" at the feature level instead of the user story level

## Issue

User stories commonly include a "why" section which describes the reason for the feature to exist, the problems which it solves, and its benefits. Knowing the "why" is essential for the entire development team as it provides context.

A "Nimble user story" is unlike the average user story. It is way more granular.

If we look at [how Atlassian defines a user story](https://www.atlassian.com/agile/project-management/user-stories) for example, what *they* call a user story is what *we* call a feature. This example is representative of an average user story in the Agile world.

Let's briefly compare Nimble's vs. average user stories:

```markdown
| Nimble     | Average    |                                    |
|------------|------------|------------------------------------|
| Module     | Epic       |                                    |
| Feature    | User story |                                    |
| User story | (Sub)task  | <- actionable level for developers |
```

The consequence of our granular breakdown is that Product Managers produce a *lot* of user stories, each with their own “why.”

There are two aspects which I think we can improve:

1. The time needed to write user stories
2. The pertinence of the “why”

## Solution

Instead of writing a “why” for each user story, Product Managers could write a general “why” at the feature level. This should be possible without reducing the contextual information for developers because our features are already quite granular. The purpose of each story in a given feature is a sub-set of the feature’s “why.”

For each user story, there could be an additional and optional context. The context would be used to clarify how a particular user story fits in the feature’s “why” if there is an ambiguity.

For example, in the WORPT project, there is a feature called “User can fetch trending coins.”

This feature contains several user stories which, for the most part, clearly tied to the feature’s purpose. However, there is one user story titled “As a developer, I can fetch Trending coins from CoinMarketCap periodically” which could bear some amibguity. Why are we fetching from CoinMarketCap?

In that case, the additional and optional context could simply be:

> We use CoinMarketCap to determine which coins are trending.
> 

It’s quick to write and yet, in addition to the feature’s “why,” provides clarity about the user story.

The only condition for this to work is that Product Managers write a clear and comprehensive “why” for each feature.

## Who Benefits?

- Product Managers. They will spend more time writing a comprehensive “why” for each feature, but they will drastically reduce the time needed to write a different “why” for each user story.
- Engineers. They will get better context thanks to a more thorough “why.” As it stands, writing a contextual, useful, and unique “why” for each user story is difficult and often results in not-so-helpful and not-so-different “why” in each user story.

## What's Next?

Provide an actionable list of things that must happen in order to implement the solution:

- [ ]  [ ]
- [ ]  [ ]
- [ ]  [ ]

Using a poll is encouraged to gather feedback on the RFA 👉 Use this tool: [https://gh-polls.com/](https://gh-polls.com/)