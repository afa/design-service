# coding: utf-8
class RemovePortfolioOwnerColumn < ActiveRecord::Migration
  def change
    Portfolio.find_each do |portfolio|
      if portfolio.owner_type == 'Specialist'
        portfolio.specialist = portfolio.owner
      elsif portfolio.owner_type == 'SpecialistGroup'
        portfolio.specialist_group = portfolio.owner
      end
      portfolio.save
    end
    change_table :portfolios do |t|
      t.remove :owner_id, :owner_type
    end
  end
end
