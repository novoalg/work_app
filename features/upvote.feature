Scenario: Sucessful upvote
Given a user creates a posrt
Then they should see the title
When the user upvotes a post
Then the karma count should go up
