require 'spec_helper'

describe OrdersController do

  describe "GET 'get_price'" do
    it "returns http success" do
      get 'get_price'
      response.should be_success
    end
  end

end
