Feature: save_api

    As a user
    So that I (the user) can add a new eve character skill api key
    I want to be able to input my api ID and Verification Code
    So I can view my character's skill information

Background:

    Given a logged in user

Scenario: User submits a new eve character skill api key
    When user visits the add new character page
    And user inputs "1867200" as their "Eve api identifier"
    And user inputs "oReWk9nG5QutSKn03RINpBXajnDtU2egla3uTr4dLQDV4kVTeQodWgy1He7ECeU4" as their "Verification code"
    And user clicks "Create Api key"
    Then user should be presented with "1867200" as their "Eve api identifier"