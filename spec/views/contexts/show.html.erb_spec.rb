require 'spec_helper'

describe "contexts/show.html.erb" do
  before(:each) do
    @context = assign(:context, stub_model(Context,
      :user => nil,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
