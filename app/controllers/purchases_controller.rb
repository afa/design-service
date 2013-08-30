require "digest/md5"
class PurchasesController < ApplicationController

  layout false
  skip_before_filter :get_before_filter

  def index
   p '---payparm', params
   sum = params.delete('OutSum')
   pay = params.delete('InvId')
   sign = params.delete('SignatureValue')
   render :text => 'fail' and return if sum.blank? || pay.blank?
   purchase = Purchase.find_by_id(pay)
   render :text => 'fail' and return unless purchase
   render :text => 'fail' and return unless MD5.hexdigest([[sum, pay, ROBOPASS], (params.keys - ["action", "controller"]).sort.map{|k| params[k] }].flatten.join(':')).downcase != sign.downcase
   purchase.ok
   render :text => "OK#{pay}"
  end

  def ok
   redirect_to orders_path
  end

  def fail
   p '---payparm', params
   sum = params.delete('OutSum')
   pay = params.delete('InvId')
   sign = params.delete('SignatureValue')
   render :text => 'fail' and return if sum.blank? || pay.blank?
   purchase = Purchase.find_by_id(pay)
   render :text => 'fail' and return unless purchase
   redirect_to new_order_path
  end
end
