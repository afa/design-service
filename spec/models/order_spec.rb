require 'spec_helper'

describe Order do
 before do
  @clnt = FactoryGirl.create(:user, :role => 'client')
  User.current = @clnt
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
    before do
     @order = FactoryGirl.create(:order, :work_state => 'specialist_agreed', :price => 10000.0, :client => @clnt, :orderable => @orderable)
      #:payment_state => 'advance_paid',
    end
    it "should create payment on transmit" do
     @order.payments.should be_empty
     p @order, @order.payments
     @order.agree!
     p @order, @order.payments
     @order.should be_client_agreed
     p @order, @order.payments
     @order.payments.should_not be_empty
    end
   end
   describe "in state client_agreed" do
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
