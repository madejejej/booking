Feature: Login system
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

  @javascript
  Scenario: Logging in
    Given I’m on the login page
    When I provide my credentials
    And I press the login button
    Then I should see "Signed in successfuly"
