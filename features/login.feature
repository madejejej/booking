Feature: Login system

  @javascript
  Scenario: Logging in
    Given I’m on the login page
    When I fill in "email" with "user@example.com"
    And I fill in "password" with "12345678"
    And I press "Login"
    Then I should see "Signed in successfuly"
