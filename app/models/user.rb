class User < ActiveRecord::Base
  # Include default devise modules. Others available are: :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  validates :username, length: {minimum: 3}, immutable: true

  has_many :received_messages, class_name: 'Message', foreign_key: 'to_id'
  has_many :sent_messages, class_name: 'Message', foreign_key: 'from_id'

  has_one :specialist, foreign_key: 'profile_id'
  has_one :client, foreign_key: 'profile_id'

  # allows user to sign in using both email and username
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  attr_accessor :login

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
    role == 'admin'
  end

  def self.new_guest
    u = new(name: "Гость", email: "guest_#{Time.now.to_i}_#{rand(99)}@design-service.ru")
    u.role = 'guest'
    u.save!(validate: false)
    u
  end

  def guest?
    role == 'guest'
  end
  def registered?
    ! guest?
  end
end