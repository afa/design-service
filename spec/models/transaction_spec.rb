require 'spec_helper'

describe Transaction do
 describe "when order paid" do
  before do
   @clnt = FactoryGirl.create(:user)
   @orderable = FactoryGirl.create(:replanning_endorsement)
  end
  describe "on purchase paid" do
   before do
    @order = FactoryGirl.create(:order, :work_state => 'client_agreed', :price => 10000.0, :orderable => @orderable, :client => @clnt)
    @payment = FactoryGirl.create(:payment, :state => "requested", :order => @order, :user => @clnt, :amount => @order.need_amount)
    @purchase = FactoryGirl.create(:purchase, :payment => @payment, :order => @order, :user => @clnt, :amount => @payment.amount)
   end
   it "should create transaction" do
    @order.transactions.should be_empty
    p @payment
    @purchase.ok
    p @payment
    @purchase.commit_payment
    p @payment
    p Transaction.all
    @order.transactions.should_not be_empty
   end
  end
 end
end
