require 'spec_helper'

describe "replanning_endorsements/new" do
  before(:each) do
    assign(:replanning_endorsement, stub_model(ReplanningEndorsement,
      :developed_by_general_projector => false,
      :replanning_organization_licenzed => false,
      :flat_area => "9.99"
    ).as_new_record)
  end

  it "renders new replanning_endorsement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", replanning_endorsements_path, "post" do
      assert_select "input#replanning_endorsement_developed_by_general_projector[name=?]", "replanning_endorsement[developed_by_general_projector]"
      assert_select "input#replanning_endorsement_replanning_organization_licenzed[name=?]", "replanning_endorsement[replanning_organization_licenzed]"
      assert_select "input#replanning_endorsement_flat_area[name=?]", "replanning_endorsement[flat_area]"
    end
  end
end
