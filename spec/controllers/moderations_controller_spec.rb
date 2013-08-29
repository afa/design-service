require 'spec_helper'

describe ModerationsController do

  describe "GET 'accept'" do
    it "returns http success" do
      get 'accept'
      response.should be_success
    end
  end

  describe "GET 'reject'" do
    it "returns http success" do
      get 'reject'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
