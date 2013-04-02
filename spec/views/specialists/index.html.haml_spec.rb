require 'spec_helper'

describe "specialists/index" do
  before(:each) do
    assign(:specialists, [
      stub_model(Specialist,
        :type => 1,
        :acreditation_level => 2,
        :profile => nil
      ),
      stub_model(Specialist,
        :type => 1,
        :acreditation_level => 2,
        :profile => nil
      )
    ])
  end

  it "renders a list of specialists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
