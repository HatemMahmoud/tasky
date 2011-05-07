require 'spec_helper'

describe "contexts/edit.html.erb" do
  before(:each) do
    @context = assign(:context, stub_model(Context,
      :user => nil,
      :name => "MyString"
    ))
  end

  it "renders the edit context form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contexts_path(@context), :method => "post" do
      assert_select "input#context_user", :name => "context[user]"
      assert_select "input#context_name", :name => "context[name]"
    end
  end
end
