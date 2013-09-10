class Review < ActiveRecord::Base
  has_paper_trail
  belongs_to :order, counter_cache: true
  belongs_to :user
end
