require 'spec_helper'

describe "AuthenticationPages" do
    subject { page }

    describe "sign in" do
        before { visit signin_path }

        describe "with invalid information" do
            before { click_button "Sign in" }
            it { should have_selector('div.alert.alert-warning', :text => 'Username and password do not match') }

            describe "after visiting another page" do
                before { click_link "Hot" }
                it { should_not have_selector('div.alert.alert-warning') }
            end
        end

        describe "with valid information" do
            let(:user) { FactoryGirl.create(:user) }
            before do
                fill_in "Username", :with => user.username
                fill_in "Password", :with => user.password
                click_button "Sign"
            end
            it { should have_link('preferences', :href => user_path(user)) }
            it { should have_link('logout', :href => signout_path) }
            it { should_not have_link('login', :href => signin_path) }
        end
    end
end
