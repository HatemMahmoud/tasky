require 'spec_helper'

describe "tasks/new.html.erb" do
  before(:each) do
    assign(:task, stub_model(Task,
      :user => nil,
      :name => "MyString",
      :done => false
    ).as_new_record)
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tasks_path, :method => "post" do
      assert_select "input#task_user", :name => "task[user]"
      assert_select "input#task_name", :name => "task[name]"
      assert_select "input#task_done", :name => "task[done]"
    end
  end
end
