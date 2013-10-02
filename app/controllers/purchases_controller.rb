require "digest/md5"
class PurchasesController < ApplicationController

  layout false
  skip_before_filter :verify_authenticity_token, :only => [:index, :ok, :bad] 
  skip_before_filter :get_current_user
  skip_before_filter :load_events_for_spec

  def index
   sum = params.delete('OutSum')
   pay = params.delete('InvId')
   sign = params.delete('SignatureValue')
   render :text => 'fail' and return if sum.blank? || pay.blank?
   purchase = Purchase.find_by_id(pay)
   unless purchase
    render :text => 'fail'
    return
   end
   p "---md", sign, [[sum, pay, ROBOPASS], (params.keys - ["action", "controller"]).sort.map{|k| params[k] }].flatten.join(':') , Digest::MD5.hexdigest([[sum, pay, ROBOPASS], (params.keys - ["action", "controller"]).sort.map{|k| params[k] }].flatten.join(':')).downcase 
   if Digest::MD5.hexdigest([[sum, pay, ROBOPASS], (params.keys - ["action", "controller"]).sort.map{|k| params[k] }].flatten.join(':')).downcase != sign.downcase
    render :text => 'fail'
    return
   end
   begin
   purchase.amount = sum
   purchase.ok
   rescue Exception => e
   p "---ex", e
   end
   if purchase.paid?
    render :text => "OK#{pay}"
   else
    render :text => "fail"
   end
  end

  def ok
   redirect_to orders_path
  end

  def bad
   sum = params.delete('OutSum')
   pay = params.delete('InvId')
   sign = params.delete('SignatureValue')
   render :text => 'fail' and return if sum.blank? || pay.blank?
   purchase = Purchase.find_by_id(pay)
   render :text => 'fail' and return unless purchase
   purchase.bad
   redirect_to new_order_path
  end
end
