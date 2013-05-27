# to be included into model
module Likeable
  extend ActiveSupport::Concern
  included do
    has_many :likes, as: :likeable
    has_many :users_liked, through: :likes, source: :user
  end

  def like_from?(user)
    users_liked.where(id: user.id).count > 0
  end

  def set_like_from(user)
    return false  if profile == user
    return false  if like_from?(user)
    users_liked << user
  end

  def delete_like_from(user)
    users_liked.delete(user)
  end

  def toggle_like_from(user)
    if like_from?(user)
      delete_like_from(user)
    else
      set_like_from(user)
    end
  end

  def number_of_likes
    users_liked.count
  end

  def toggle_like_text_for(user)
    like_from?(user) ? 'Из избранного' : 'В избранное'
  end
end