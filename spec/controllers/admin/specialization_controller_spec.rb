require 'spec_helper'

describe Admin::SpecializationController do

  describe "GET 'specialists'" do
    it "returns http success" do
      get 'specialists'
      response.should be_success
    end
  end

end
