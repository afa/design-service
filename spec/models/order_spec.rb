require 'spec_helper'

describe Order do
 before do
  @clnt = FactoryGirl.create(:user)
  @orderable = FactoryGirl.create(:replanning_endorsement)
 end
 describe "state_machine" do
  describe "for work state" do
   describe "in state draft" do
    before do
     @order = FactoryGirl.create(:order, :orderable => @orderable, :client => @clnt)
    end
    it {@order.purchases.should be_empty}
   end
   describe "in state moderator_suggested" do
   end
   describe "in state specialist_agreed" do
   end
   describe "in state client_agreed" do
    before do
     @order = FactoryGirl.create(:order, :payment_state => 'advance_paid', :work_state => 'client_agreed', :client => @clnt, :orderable => @orderable)
    end
    it "should create payment on transmit" do
     @order.payments.should be_empty
     @order.start_work!
     @order.should be_in_work
     @order.payments.should_not be_empty
    end
   end
   describe "in state in_work" do
   end
   describe "in state work_accepted" do
   end
  end
  describe "for payment state" do
   describe "in state not_paid" do
   end
   describe "in state advance_paid" do
   end
   describe "in state paid" do
   end
  end
 end
end
