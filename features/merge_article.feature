Feature: Merge Articles
  As a blog administrator
  In order to remove duplicates articles
  I want to be able to merge two articles

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And the following articles exist
      | id | title    | body    |
      | 2  | Foobar   | Lorem   |
      | 3  | Foobar 2 | Lorem 2 |

  Scenario: Successfully merge articles
    Given I am on the article page for "Foobar"
    When I fill in "merge_with" with "3"
    And I press "Merge"
    Then the article "Foobar" should have body "Lorem Lorem 2"

Feature: Merge Articles as publisher
  As a blog publisher
  Im not able to merge articles

  Background:
    Given the blog is set up
    And I am logged into the admin panel as publisher
    And the following articles exist
      | id | title    | body    |
      | 2  | Foobar   | Lorem   |
      | 3  | Foobar 2 | Lorem 2 |

  Scenario: Successfully merge articles
    Given I am on the article page for "Foobar"
    Then I should not see "Merge"
