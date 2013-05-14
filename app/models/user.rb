class User < ActiveRecord::Base
  ROLES = ['guest', 'client', 'admin', 'specialist', 'moderator']

  # Include default devise modules. Others available are: :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  has_many :received_messages, class_name: 'Message', foreign_key: 'to_id'
  has_many :sent_messages, class_name: 'Message', foreign_key: 'from_id'
  has_many :orders, foreign_key: 'client_id'
  has_one :specialist, foreign_key: 'profile_id'
  has_and_belongs_to_many :liked_specialists, class_name: 'Specialist', join_table: 'specialist_likes'

  scope :with_orders, -> { where('orders_count > 0') }

  validates :username, length: {minimum: 3}, immutable: true

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

  def to_s
    "#{full_name} [#{username}]"
  end
end