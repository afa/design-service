class PersonalAccountsController < ApplicationController
  before_filter :authenticate_user!

  def history
  end

  def replenishment
  end

  def acts
  end

  def contracts
  end
end
