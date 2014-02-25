Given /^a user visits the signin page$/ do
    visit signin_path
end

When /^they submit invalid signin information$/ do
    click_button "login"
end

Then /^they should see an error message$/ do
    page.should have_selector('div.alert.alert-warning')
end

Given /^the user has an account$/ do
    @user = User.create(:username => "foobar", :email => "user@email.com", :password => "foobar", :password_confirmation => "foobar")
end

When /^the user submits valid signin information$/ do
    fill_in "Username", :with => @user.username
    fill_in "Password", :with => @user.password
    click_button "login"
end

Then /^they should see their profile page$/ do
    page.should have_content(@user.username)
end

Then /^they should see a logout link$/ do
    page.should have_content('logout')
end
