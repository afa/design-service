require 'spec_helper'

describe "EngineeringSystems" do
  describe "GET /engineering_systems" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get engineering_systems_path
      response.status.should be(200)
    end
  end
end
