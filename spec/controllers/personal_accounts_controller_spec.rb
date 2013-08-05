require 'spec_helper'

describe PersonalAccountsController do

  describe "GET 'history'" do
    it "returns http success" do
      get 'history'
      response.should be_success
    end
  end

  describe "GET 'replenishment'" do
    it "returns http success" do
      get 'replenishment'
      response.should be_success
    end
  end

  describe "GET 'acts'" do
    it "returns http success" do
      get 'acts'
      response.should be_success
    end
  end

  describe "GET 'contracts'" do
    it "returns http success" do
      get 'contracts'
      response.should be_success
    end
  end

end
