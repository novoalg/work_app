require 'spec_helper'

describe "votes/index" do
  before(:each) do
    assign(:votes, [
      stub_model(Vote,
        :user => nil,
        :post => nil,
        :direction => "Direction"
      ),
      stub_model(Vote,
        :user => nil,
        :post => nil,
        :direction => "Direction"
      )
    ])
  end

  it "renders a list of votes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Direction".to_s, :count => 2
  end
end
