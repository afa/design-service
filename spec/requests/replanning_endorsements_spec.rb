require 'spec_helper'

describe "ReplanningEndorsements" do
  describe "GET /replanning_endorsements" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get replanning_endorsements_path
      response.status.should be(200)
    end
  end
end
