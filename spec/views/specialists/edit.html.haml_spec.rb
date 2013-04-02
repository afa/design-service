require 'spec_helper'

describe "specialists/edit" do
  before(:each) do
    @specialist = assign(:specialist, stub_model(Specialist,
      :type => 1,
      :acreditation_level => 1,
      :profile => nil
    ))
  end

  it "renders the edit specialist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", specialist_path(@specialist), "post" do
      assert_select "input#specialist_type[name=?]", "specialist[type]"
      assert_select "input#specialist_acreditation_level[name=?]", "specialist[acreditation_level]"
      assert_select "input#specialist_profile[name=?]", "specialist[profile]"
    end
  end
end
