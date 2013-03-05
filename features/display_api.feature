Feature: display_api

    As a user
    So that I (the user) can view my eve character data
    I want to be able to see data associated with my api key

Background:

    Given a logged in user
    Given an api_key with a skill in training

Scenario: User submits a new eve character skill api key with a skill in training
    When user visits their api_key show page
    Then user should be presented with "1867200" as their "Eve api identifier"
    Then the user should see "Skill in training?: true"
    Then the user should see "UTC"