# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  username       :string(255)
#  email          :string(255)
#  remember_token :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  admin          :boolean
#  karma          :integer          default(0)
#  link_karma     :integer          default(0)
#

require 'spec_helper'

describe User do
    before do
        @user = User.new(:username => "ramrod", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar")
    end

    subject { @user }

    it { should respond_to(:username) }
    it { should respond_to(:email) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:authenticate) }


    it { should be_valid }

    describe "when username is too long" do
        before { @user.username = "a" * 51 }
        it { should_not be_valid }
    end

    describe "when username is not present" do
        before { @user.username = " " }
        it { should_not be_valid }
    end

    describe "when email format is invalid" do
        it "should be invalid" do
            addresses = %w[user@foo,com user_at_foo.org example.user@foo.
foo@bar_baz.com foo@bar+baz.com]
            addresses.each do |invalid_address|
                @user.email = invalid_address
                @user.should_not be_valid
            end
        end
    end

    describe "when email format is valid" do
        it "should be valid" do
            addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
            addresses.each do |valid_address|
                @user.email = valid_address
                @user.should be_valid
            end
        end
    end

    describe "remember token" do
        before { @user.save }
        its(:remember_token) { should_not be_blank }
    end
end
