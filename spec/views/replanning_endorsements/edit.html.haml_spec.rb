require 'spec_helper'

describe "replanning_endorsements/edit" do
  before(:each) do
    @replanning_endorsement = assign(:replanning_endorsement, stub_model(ReplanningEndorsement,
      :developed_by_general_projector => false,
      :replanning_organization_licenzed => false,
      :flat_area => "9.99"
    ))
  end

  it "renders the edit replanning_endorsement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", replanning_endorsement_path(@replanning_endorsement), "post" do
      assert_select "input#replanning_endorsement_developed_by_general_projector[name=?]", "replanning_endorsement[developed_by_general_projector]"
      assert_select "input#replanning_endorsement_replanning_organization_licenzed[name=?]", "replanning_endorsement[replanning_organization_licenzed]"
      assert_select "input#replanning_endorsement_flat_area[name=?]", "replanning_endorsement[flat_area]"
    end
  end
end
