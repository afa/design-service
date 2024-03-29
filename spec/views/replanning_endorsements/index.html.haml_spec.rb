require 'spec_helper'

describe "replanning_endorsements/index" do
  before(:each) do
    assign(:replanning_endorsements, [
      stub_model(ReplanningEndorsement,
        :developed_by_general_projector => false,
        :replanning_organization_licenzed => false,
        :flat_area => "9.99"
      ),
      stub_model(ReplanningEndorsement,
        :developed_by_general_projector => false,
        :replanning_organization_licenzed => false,
        :flat_area => "9.99"
      )
    ])
  end

  it "renders a list of replanning_endorsements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
