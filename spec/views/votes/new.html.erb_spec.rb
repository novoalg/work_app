require 'spec_helper'

describe "votes/new" do
  before(:each) do
    assign(:vote, stub_model(Vote,
      :user => nil,
      :post => nil,
      :direction => "MyString"
    ).as_new_record)
  end

  it "renders new vote form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => votes_path, :method => "post" do
      assert_select "input#vote_user", :name => "vote[user]"
      assert_select "input#vote_post", :name => "vote[post]"
      assert_select "input#vote_direction", :name => "vote[direction]"
    end
  end
end
