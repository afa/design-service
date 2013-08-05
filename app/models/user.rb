class User < ActiveRecord::Base
  has_one :profile
  before_create :new_profile
  accepts_nested_attributes_for :profile

  extend Enumerize
  enumerize :role, in: ['guest', 'client', 'admin', 'specialist', 'moderator']

  # Include default devise modules. Others available are: :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]


  
  has_many :received_messages, as: :recipient
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', inverse_of: :sender

  has_many :orders, foreign_key: 'client_id'
  has_one :specialist
  has_one :avatar, as: :imageable_single, class_name: 'Photo'

  scope :with_orders, -> { where('orders_count > 0') }

  validates :username, length: {minimum: 3}, immutable: true

  # allows user to sign in using both email and username
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  attr_accessor :login
  
  delegate :fake_name, :middle_name, :name, :surname, :to_s, to: :profile

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
    username = "guest_#{Time.now.to_i}_#{rand(99)}"
    user = User.new(username: username, email: "#{username}@design-service.ru", profile_attributes: {name: 'Гость'}) do |u|
      u.role = 'guest'
    end
    
    #user.new_profile
    user.save!(validate: false)
    user
  end

  def guest?
    role == 'guest'
  end
  def registered?
    ! guest?
  end

  def messages
    Message.by_user(id)
  end

  def specialization
    specialist ? specialist.specialization : :not_a_specialist
  end

  def new_profile
    return if profile
    build_profile do |p|
      p.fake_name = 'My fake name'
      p.middle_name = 'My middle name'
      p.name = 'My name'
      p.surname = 'My surname'
    end
  end
end