Feature: Authenticating as an Organiser
  In order to add shows and movies to the site
  A user
  Should be able to provide theirs Organisation data

  @javascript
  Scenario: Registering an Organisation
    Given I'm signed in
    And I'm on the "register organisation" page
    When I provide my organisation data
    And I press the "Register" button
    Then my organisation should be registered
