require 'spec_helper'

describe Order do
 before do
  @clnt = FactoryGirl.create(:user, :role => 'client')
  User.current = @clnt
  @orderable = FactoryGirl.create(:replanning_endorsement)
  @spec = FactoryGirl.create(:user, :role => 'specialist')
  @spec_info = FactoryGirl.create(:specialist, :user_id => @spec.id)
 end
 describe "state_machine" do
  describe "for work state" do
   describe "in state draft" do
    before do
     @order = FactoryGirl.create(:order, :orderable => @orderable, :client => @clnt)
    end
    it {@order.purchases.should be_empty}
    context "order without selected specialist" do
     before do
      @order.price = 10000.0
      @order.executor = nil
     end
     it "when price_set should not change state" do
      @order.set_price
      @order.work_state.should == "draft"
     end
     it "should change state when specialist set" do
      @order.executor = @spec
      @order.set_price
      @order.work_state.should == 'moderator_suggested'
     end
    end
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
     @order.agree!
     @order.should be_client_agreed
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
 # нужен метод "вернуть остаток на кошелек заказчика". нужна оплата с кошелька заказа.
 context "order money to qiwi" do
  before do
   @order = FactoryGirl.create(:order, :price => 5000.0, :orderable => @orderable, :client => @clnt)
   @payment = FactoryGirl.create(:payment, :order => @order, :user => @clnt, :amount => 5000.0, :state => :requested)
   @purchase = FactoryGirl.create(:purchase, :order => @order, :payment => @payment, :amount => 6000.0, :user => @clnt)
  end
  it "should create two transactions for sum more than payment" do
   @purchase.ok
   @clnt.transactions.should have(2).transactions
   @order.transactions.should have(1).transactions
   @clnt.qiwi.should == 6000.0
   @order
  end
 end

 context "qiwi pay" do
  before do
  end
 end
end
