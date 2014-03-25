Scenario /^Sucessful upvote$/ do
end
Given /^a user creates a post$/ do
  @post = Post.create(:title => "title", :url => "www.google.com", :subname => "all")
end

Then /^they should see the title$/ do
  page.should have_content(@post.title)
end

When /^the user upvotes a post$/ do
  visit @post
  click_button "upvote"
end

Then /^the karma count should go up$/ do
  expect @post.karma change(Post, :karma).by(1)
end
