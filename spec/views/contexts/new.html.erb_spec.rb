require 'spec_helper'

describe "contexts/new.html.erb" do
  before(:each) do
    assign(:context, stub_model(Context,
      :user => nil,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new context form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contexts_path, :method => "post" do
      assert_select "input#context_user", :name => "context[user]"
      assert_select "input#context_name", :name => "context[name]"
    end
  end
end
