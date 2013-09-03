require 'spec_helper'

describe "engineering_systems/index" do
  before(:each) do
    assign(:engineering_systems, [
      stub_model(EngineeringSystem),
      stub_model(EngineeringSystem)
    ])
  end

  it "renders a list of engineering_systems" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
