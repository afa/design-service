# coding: utf-8
class PortfolioItem < ActiveRecord::Base
  self.per_page = 4

  has_and_belongs_to_many :portfolios
  mount_uploader :photo, PhotoUploader

  def get_bunches(portfolios)
  	mas = Hash.new

  	portfolios.each do |value|
  		mas[value.id] = get_bunch_on_filter(1, '', value.id)
  	end

  	mas
  end

  def get_bunch_on_filter(page, filter, portfolio_id)
    PortfolioItem.joins("inner join portfolio_items_portfolios on portfolio_items_portfolios.portfolio_item_id = portfolio_items.id")\
    	.paginate(:page => page).where("portfolio_id = ?", portfolio_id).order("created_at asc")
  end
end
