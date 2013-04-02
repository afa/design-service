require 'spec_helper'

describe "specialists/show" do
  before(:each) do
    @specialist = assign(:specialist, stub_model(Specialist,
      :type => 1,
      :acreditation_level => 2,
      :profile => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(//)
  end
end
