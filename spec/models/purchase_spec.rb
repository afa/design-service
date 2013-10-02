require 'spec_helper'

describe Purchase do
 before do
  @clnt = FactoryGirl.create(:user)
  @orderable = FactoryGirl.create(:replanning_endorsement)
  @order = FactoryGirl.create(:order, :orderable => @orderable, :client => @clnt, :price => 10000.0, :work_state => :client_agreed)
  @payment = FactoryGirl.create(:payment, :order => @order, :user => @clnt, :amount => @order.need_amount, :state => :requested)
 end
 describe "when new" do
  
 end
 context "when bad" do
  before do
  @purchase = FactoryGirl.create(:purchase, :order => @order, :user => @user, :payment => @payment, :amount => @payment.amount)
   @purchase.bad
  end
  it "should be failed" do
   @purchase.should be_failed
  end
  it "should create new purchase" do
   Order.find(@order.id).purchases.select{|p| p.requested? }.should_not be_empty
  end
  it "should create purchase for need payment" do
   Order.find(@order.id).purchases.where(:state => :requested).first.amount.should == @order.need_amount
  end
  it "should create purchase for valid user" do
   Order.find(@order.id).purchases.where(:state => :requested).first.user.should == @user
  end
  it "should markfailed all request purchases before regen"
 end
 context "when ok" do
  before do
  @purchase = FactoryGirl.create(:purchase, :order => @order, :user => @user, :payment => @payment, :amount => @payment.amount)
   @purchase.ok
  end
  it "should mark payment paid" do
   Payment.find(@payment.id).should be_paid
  end
 end
 context "when amount less then payment amount" do
  before do
   @purchase = FactoryGirl.create(:purchase, :order => @order, :user => @user, :payment => @payment, :amount => @payment.amount - 1.0)
  end
  it "should not mark payment as paid" do
   @purchase.ok
   Payment.find(@payment.id).should_not be_paid
  end
  it "should create purchase for unpaid sum" do
   @purchase.ok
   Payment.find(@payment.id).purchases.where(:state => :requested).inject(0.0){|r, p| r + p.amount }.should == 1.0
  end
  it "should mark failed all old request purchases before regen" do
   FactoryGirl.create(:purchase, :order => @order, :user => @user, :payment => @payment, :amount => @payment.amount)
   @purchase.ok
   Payment.find(@payment.id).purchases.where(:state => :requested).count.should == 1
   Payment.find(@payment.id).purchases.where(:state => :requested).inject(0.0){|r,p| r + p.amount }.should == 1.0
  end
 end
 context "for xmlapi" do
  before do
   @purchase = FactoryGirl.create(:purchase, :order => @order, :user => @user, :payment => @payment, :amount => @payment.amount - 1.0)
  end
  context "on #robo_info" do
   before do
    resp = double(:http)
    Net::HTTP.should_receive(:get_response).and_return(resp)
    resp.should_receive(:code).and_return('200')
    resp.should_receive(:body).and_return("<?xml version=\"1.0\" encoding=\"utf-8\"?><OperationStateResponse><Result><Code>100</Code><Description>ok</Description></Result><State><Code>100</Code><RequestDate></RequestDate><StateDate></StateDate></State><Info><IncCurrLabel></IncCurrLabel><IncSum></IncSum><IncAccount></IncAccount><PaymentMethod><Code></Code><Description></Description></PaymentMethod><OutCurrLabel></OutCurrLabel><OutSum></OutSum></Info></OperationStateResponse>")
   end
   it "should #get url" do
    @purchase.robo_info
   end
   it "should return Hash" do
    @purchase.robo_info.should be_is_a(Hash)
   end
   it "should return [Result][Code]" do
    @purchase.robo_info["Result"]["Code"].should == "100"
   end
  end
 end
end
