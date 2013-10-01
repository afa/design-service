json.specialist profile.specialist, :bio_info, :work_info
json.avatar profile.avatar
json.portfolios profile.specialist.portfolios do |json, portfolio|
  json.(portfolio, :id)
  json.portfolio_html render  partial: 'portfolios/portfolio_for_profile',
                              formats: [:html], handlers: [:haml],
                              locals: {portfolio: portfolio}
end
