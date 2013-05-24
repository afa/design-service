class Like < ActiveRecord::Base
  belongs_to :user_from
  belongs_to :entity_to
  # attr_accessible :title, :body
end
