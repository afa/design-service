require 'spec_helper'

describe Payment do
 context "state_machine" do
  before do
   @user = FactoryGirl.create(:user)
   @orderable = FactoryGirl.create(:replanning_endorsement)
   @order = FactoryGirl.create(:order, :price => 10000.5, :orderable => @orderable, :client => @user)
   @payment = FactoryGirl.create(:payment, :order => @order)
  end
  subject {@payment}
  context "in state created" do
   it{should be_created}
   context "on event request" do
    it "shjould create purchase" do
     @payment.purchases.should be_empty
     @payment.request!
     @payment.should be_requested
     @payment.purchases.should_not be_empty
    end
    it "purchase amount should be ok" do
     @payment.request!
     @payment.purchases.where(:state => :requested).last.amount.should == @order.need_amount
    end
   end
  end
  context "in state requested" do
  end
  context "in state payed" do
  end
  context "in state failed" do
  end
 end
end
