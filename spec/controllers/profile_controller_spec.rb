require 'spec_helper'

describe ProfileController do

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'specialists'" do
    it "returns http success" do
      get 'specialists'
      response.should be_success
    end
  end

  describe "GET 'orders'" do
    it "returns http success" do
      get 'orders'
      response.should be_success
    end
  end

end
