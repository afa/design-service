require 'spec_helper'

describe "engineering_systems/show" do
  before(:each) do
    @engineering_system = assign(:engineering_system, stub_model(EngineeringSystem))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
