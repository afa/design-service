require 'spec_helper'

describe OrdersController do
  before do
   @user = FactoryGirl.create(:user, :role => 'client')
   sign_in(@user)
  end

  describe "GET 'get_price'" do
    it "returns http success" do
      get 'get_price'
      response.should be_success
    end
  end

end
