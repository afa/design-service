class Profile < ActiveRecord::Base
  belongs_to :user
  #attr_accessible :fake_name, :middle_name, :name, :surname
  def to_s
    "#{fake_name} [#{user.username}]"
  end
  def full_name
    "#{name} #{surname}"
  end
  delegate :avatar, :specialist, to: :user
end
