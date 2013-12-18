class PersonalAccountsController < ApplicationController
  before_filter :authenticate_user!

  def history
   
   @orders = current_user.orders #.where(:work_state => :saved_draft)
   @transactions = current_user.transactions
   @events = Event.all 
   @amount = current_user.qiwi
  end

  def 

  def replenishment
  end

  def acts
  end

  def contracts
  end

  def pa_transactions
   @transactions = current_user.transactions
   render :json => {:content => render_to_string(:partial => "personal_accounts/client/transactions.html.haml"), :what => params[:action]}
  end

  def pa_services
   @orders = current_user.orders.where(:work_state => :saved_draft)
   render :json => {:content => render_to_string(:partial => "personal_accounts/client/services.html.haml"), :what => params[:action]}
  end

  def payment1_stage1
   @order = Order.where(:id => params[:order]).first
   xml_interface = Rubykassa::XmlInterface.new() do
    self.language = :ru # can be :en, :ru is default
   end
   xml_interface.invoice_id = @order.id
   xml_interface.total = @order.price
   @groups = begin; xml_interface.get_currencies; rescue; {"CurrenciesList" => {"Groups" => {"Group" => []}}}; end["CurrenciesList"]["Groups"]["Group"].map{|g| [g["Code"], g["Description"]] }
   render :json => {:content => render_to_string(:partial => "personal_accounts/client/payment1_stage1.html.haml").html_safe, :what => 'payment1_stage1'}
  end

  def payment1_stage2
   @order = Order.where(:id => params[:order]).first
   @group = params[:group]
   xml_interface = Rubykassa::XmlInterface.new() do
    self.language = :ru # can be :en, :ru is default
   end
   xml_interface.invoice_id = @order.id
   xml_interface.total = @order.price
   @groups = begin; xml_interface.get_currencies; rescue; {"CurrenciesList" => {"Groups" => {"Group" => []}}}; end["CurrenciesList"]["Groups"]["Group"].map{|g| [g["Code"], g["Description"], g["Items"]] }.select{|g| g[0] == @group }.first[2]["Currency"]
   p "---xml", @groups
   render :json => {:content => render_to_string(:partial => "personal_accounts/client/payment1_stage2.html.haml"), :what => params[:action]}
  end

  def payment2_stage1
   @order = Order.where(:id => params[:order]).first
   render :json => {:content => render_to_string(:partial => "personal_accounts/client/payment2_stage1.html.haml"), :what => params[:action]}
  end

  def payment2_stage2
   @group = params[:group]
   @order = Order.where(:id => params[:order]).first
   render :json => {:content => render_to_string(:partial => "personal_accounts/client/payment2_stage2.html.haml"), :what => params[:action]}
  end

  def payment3_stage1
   @order = Order.where(:id => params[:order]).first
   render :json => {:content => render_to_string(:partial => "personal_accounts/client/payment3_stage1.html.haml"), :what => params[:action]}
  end

  def payment3_stage2
  end

  def payment3_stage3
  end
end
