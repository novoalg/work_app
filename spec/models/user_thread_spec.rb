require 'spec_helper'

describe UserThread do
    let(:user) { FactoryGirl.create(:user) }
    before { @user_thread = user.user_thread.build(:content => "Lorem ipsum") }
    subject { @user_thread }
end
