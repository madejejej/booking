Feature: Registration system
  In order to get access to protected sections of the site
  A user
  Should be able to register an account

  @javascript
  Scenario: Creating a registration
    Given I’m on the "register" page
    When I provide my email and confirm my password
    And I press the "Register" button
    Then I should have a registered account
    And I should be logged in