class PersonalAccountsController < ApplicationController
  before_filter :authenticate_user!

  def history
   
   @orders = current_user.orders.where(:work_state => :saved_draft)
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
end
