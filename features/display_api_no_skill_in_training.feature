Feature: display_api_no_skill_in_training

    As a user
    So that I (the user) can view my eve character data
    I want to be able to see data associated with my api key
    And not see a skill in training

Background:

    Given a logged in user
    Given an api_key with a skill not training

Scenario: User submits a new eve character skill api key with a skill in training
    When user visits their api_key show page
    Then the user should see "Eve Api Id: 1878387"
    Then the user should see "Skill in training?: false"
    Then the user should not see "UTC"
    Then the user should not see ":queuePosition=>"0""