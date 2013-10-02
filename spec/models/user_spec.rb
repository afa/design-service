require 'spec_helper'

describe User do
 describe "when real user" do
  before do
   @user = FactoryGirl.create(:user)
   FactoryGirl.create_list(:transaction, 2, :destination => @user, :amount => 3000.0)
   FactoryGirl.create_list(:transaction, 3, :source => @user, :amount => 1000.0)
  end
  it "should calc qiwi over transactions" do
   @user.qiwi.should == 3000.0
  end
 end
end
