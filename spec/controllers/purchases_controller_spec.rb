require 'spec_helper'
require 'digest/md5'

describe PurchasesController do
 before do
  @user = FactoryGirl.create(:user)
 end
 describe "on #result" do
  it "should on :get be success" do
   get :index
   response.should be_ok
  end
  it "should return fail on empty req" do
   get :index
   response.body.should match(/fail/)
  end
  describe "when valid purchase" do
   before do
    @able = FactoryGirl.create(:replanning_endorsement)
    @order = FactoryGirl.create(:order, :orderable => @able, :price => 5000.0, :work_state => :client_agreed, :client => @user)
    @payment = FactoryGirl.create(:payment, :state => :requested, :amount => @order.need_amount, :order => @order, :user => @user)
    @purchase = FactoryGirl.create(:purchase, :payment => @payment, :amount => @payment.amount, :order => @order, :user => @user)
    @sum = Digest::MD5.hexdigest("#{@purchase.amount.to_s}:#{@purchase.id.to_s}:")
    ROBOPASS = ''
   end
   it "should ok for valid purchase" do
    get :index, {:OutSum => @purchase.amount, :InvId => @purchase.id.to_s, :SignatureValue => @sum}
    response.should be_success
   end
   it "should mark purchase paid" do
    get :index, {:OutSum => @purchase.amount, :InvId => @purchase.id.to_s, :SignatureValue => @sum}
    Purchase.find(@purchase.id).should be_paid
   end
   it "should mark payment paid" do
    get :index, {:OutSum => @purchase.amount, :InvId => @purchase.id.to_s, :SignatureValue => @sum}
    Purchase.find(@purchase.id).payment.should be_paid
   end
   it "should create transaction for sum" do
    @order.transactions.should be_empty
    get :index, {:OutSum => @purchase.amount, :InvId => @purchase.id.to_s, :SignatureValue => @sum}
    order = Order.find(@order.id)
    order.transactions.should_not be_empty
    order.transactions.each{|t| t.source.should be_nil }  
    order.transactions.each{|t| t.destination.should == @user }  
    order.transactions.map{|t| t.amount }.sum.should == @purchase.amount  
   end
   it "should update paid sum in purchase" do
    @sum = Digest::MD5.hexdigest("#{(@purchase.amount - 1.0).to_s}:#{@purchase.id.to_s}:")
    get :index, {:OutSum => @purchase.amount - 1.0, :InvId => @purchase.id.to_s, :SignatureValue => @sum}
    Payment.find(@payment.id).purchases.where(:state => :requested).map(&:amount).sum.should == 1.0
   end
   it "should return valid status" do
    get :index, {:OutSum => @purchase.amount, :InvId => @purchase.id.to_s, :SignatureValue => @sum}
    response.body.should match(/^OK#{@purchase.id.to_s}$/)
   end
  end
 end
 describe "on #ok" do
  before do
   @able = FactoryGirl.create(:replanning_endorsement)
   @order = FactoryGirl.create(:order, :orderable => @able, :price => 5000.0, :work_state => :client_agreed, :client => @user)
   @payment = FactoryGirl.create(:payment, :state => :requested, :amount => @order.need_amount, :order => @order, :user => @user)
   @purchase = FactoryGirl.create(:purchase, :payment => @payment, :amount => @payment.amount, :order => @order, :user => @user)
   @sum = Digest::MD5.hexdigest("#{@purchase.amount.to_s}:#{@purchase.id.to_s}:")
   ROBOPASS = ''
  end
  it "should redirect to orders" do
   get :ok, {:OutSum => @purchase.amount, :InvId => @purchase.id.to_s, :SignatureValue => @sum}
   response.should redirect_to(orders_path)
  end
 end
 describe "on #bad" do
  it "should redirect to new order"
 end
end
