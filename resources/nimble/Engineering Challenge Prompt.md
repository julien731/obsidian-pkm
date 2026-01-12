---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2025-05-26
---

# Engineering Challenge Prompt

You are a principal software engineer with 20+ years of experience. You are tasked to create a new web application using Ruby on Rails.

This application will be used to extract large amounts of data from a Google search. In so doing, you may need to find a way to work around the limitations of mass-searching keywords, as Google prevents it. Be creative. **Using a third-party API to acquire Google search data is not valid.**

Below are user stories that describe the application’s features.

- As a user, I can register with an email and password
- As a user, I can login with an email and password
- As a logged-in user, I can upload a CSV file containing keywords
    - The CSV file contains only one column called “keyword”
    - The CSV file can contain from 1 to 100 keywords
- As a logged-in user, I can start a keyword search
- As a logged-in user, when I upload a CSV file, the following flow triggers:
    - For each keyword:
        - Run a Google search
        - Count, out of the first page of results only, the total number of AdWords advertisers on the page.
        - The total number of links (all of them) on the page.
        - The total number of search results for the keyword (e.g., “About 21,600,000 results (0.42 seconds)”).
        - Grab the HTML code of the page/cache of the page.
        - Save all of the above to a database.
- As a logged-in user, after I uploaded a CSV file and the search flow has completed, I can see a table with the list of keywords from the CSV and, for each keyword, I can see the data saved during the Google search
- As a logged-in user, I can search any of the saved information via a search field

For authentication features, please use Devise. I prefer to use an established standard rather than coding something from scratch.

In order to achieve the user stories above, the Rails application must provide a UI for the following pages/functions:

- Login
- Register
- Upload a CSV file
- View the list of keywords
- View the saved information for each keyword
- Search

This Rails application must also provide an API secured by authentication (same as the rest of the application). The API must provide the following endpoints:

- `POST /login`
- `GET /keywords` to retrieve the list of keywords
- `POST /keywords` to upload the CSV file
- `GET /search` to search the saved information for each keyword

Users would need to sign up with the web UI (in the browser) in order to use the API.

Non-functional requirements:

- Use Ruby on Rails 7+
- Use Ruby 3.3.4
- Use PostgreSQL
- Use Bootstrap, Tailwind, or Foundation for the web UI
- Use SAAS as the CSS pre-processor
- Write tests using your framework of choice
- The app must be Dockerized

Additional context:

- I will scaffold a new Rails app using Rails 7.1 to have native support for Dockerization
- I expect you to write the necessary code to add all the features described above on top of that brand new Rails 7.1 app (called “keyword-challenge”).

Actions plan:

1. Write the `docker-compose.yml` file which is not scaffolded by Rails.
2. Write all the necessary code for the features described above.
3. Provide a zip file containing all the necessary files properly organized.
4. I will copy-paste the files from your zip into my new Rails app directory.
5. Provide a [[`README.md`]] file with the necessary steps to run the project and to run the tests.
6. Write the necessary pipeline configuration to run the tests via Github Action (the code will be hosted on Github) when a new PR is created or updated.