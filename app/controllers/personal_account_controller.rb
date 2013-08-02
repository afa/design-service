class PersonalAccountController < ApplicationController
  defaults singleton: true
  before_filter :authenticate_user!

  def history
  end

  def replenishment
  end

  def acts
  end

  def contracts
  end
protected
  def begin_of_association_chain
    current_user
  end
  def page_subtitle
    "ЛИЦЕВОЙ СЧЕТ"
  end
end
