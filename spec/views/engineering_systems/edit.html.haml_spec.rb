require 'spec_helper'

describe "engineering_systems/edit" do
  before(:each) do
    @engineering_system = assign(:engineering_system, stub_model(EngineeringSystem))
  end

  it "renders the edit engineering_system form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", engineering_system_path(@engineering_system), "post" do
    end
  end
end
