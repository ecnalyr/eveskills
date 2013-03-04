Feature: save_api

    As a user
    So that I (the user) can add a new eve character skill api key
    I want to be able to input my api ID and Verification Code
    So I can view my character's skill information

Background:

    Given a logged in user

Scenario: User submits a new eve character skill api key with a skill in training
    When user visits the add new character page
    And user inputs "1867200" as their "Eve api identifier"
    And user inputs "oReWk9nG5QutSKn03RINpBXajnDtU2egla3uTr4dLQDV4kVTeQodWgy1He7ECeU4" as their "Verification code"
    And user clicks "Create Api key"
    Then user should be presented with "1867200" as their "Eve api identifier"
    Then the user should see "Skill in training?: true"

Scenario: User submits a new eve character skill api key with a skill in training
    When user visits the add new character page
    And user inputs "1878387" as their "Eve api identifier"
    And user inputs "N918tK4e6MH1D6R61JjPuyxsylg9o2TIrdtuAK6mwhNW3zWy1KTZH7946jY2aV1L" as their "Verification code"
    And user clicks "Create Api key"
    Then user should be presented with "1867200" as their "Eve api identifier"
    Then the user should see "Skill in training?: false"