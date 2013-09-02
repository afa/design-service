require 'spec_helper'

describe "engineering_systems/new" do
  before(:each) do
    assign(:engineering_system, stub_model(EngineeringSystem).as_new_record)
  end

  it "renders new engineering_system form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", engineering_systems_path, "post" do
    end
  end
end
