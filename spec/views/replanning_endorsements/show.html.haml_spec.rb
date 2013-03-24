require 'spec_helper'

describe "replanning_endorsements/show" do
  before(:each) do
    @replanning_endorsement = assign(:replanning_endorsement, stub_model(ReplanningEndorsement,
      :developed_by_general_projector => false,
      :replanning_organization_licenzed => false,
      :flat_area => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/9.99/)
  end
end
