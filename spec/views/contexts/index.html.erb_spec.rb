require 'spec_helper'

describe "contexts/index.html.erb" do
  before(:each) do
    assign(:contexts, [
      stub_model(Context,
        :user => nil,
        :name => "Name"
      ),
      stub_model(Context,
        :user => nil,
        :name => "Name"
      )
    ])
  end

  it "renders a list of contexts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
