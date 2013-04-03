class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_keys => [:login]
  attr_accessible :name, :surname, :middle_name

  validates :username, length: {minimum: 3}, immutable: true

  has_many :received_messages, class_name: 'Message', foreign_key: 'to_id'
  has_many :sent_messages, class_name: 'Message', foreign_key: 'from_id'

  # allows user to sign in using both email and username
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  attr_accessor :login
  attr_accessible :username, :login
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def full_name
    "#{name} #{surname}"
  end
  
  
  def admin?
    ACCESS_LEVELS[access_level] == :admin
  end
  def specialist?
    ACCESS_LEVELS[access_level] == :specialist
  end
  def simple_user?
    ACCESS_LEVELS[access_level] == :simple_user
  end
  
  ACCESS_LEVELS = {simple_user: 0, specialist: 1, modearator: 3, expert: 5, admin: 10}.invert
end
