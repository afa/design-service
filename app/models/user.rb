class User < ActiveRecord::Base
  cattr_accessor :current

  has_one :profile
  #after_initialize :prepare_new_profile
  before_create :new_profile
  accepts_nested_attributes_for :profile

  extend Enumerize
  enumerize :role, in: ['guest', 'client', 'admin', 'specialist', 'moderator', 'main_moderator']

  # Include default devise modules. Others available are: :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  has_many :received_messages, :class_name => 'Message', as: :recipient
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', inverse_of: :sender

  has_many :transactions_in, :as => :destination, :class_name => 'Transaction'
  has_many :transactions_out, :as => :source, :class_name => 'Transaction'

  has_many :orders, foreign_key: 'client_id' #do;  includes(:orderable); end ## in Rails 4 it'll be possible to prevent N+1 problem here, but now we should use includes in controller
  has_many :payments
  has_many :purchases
  has_one :specialist
  mount_uploader :avatar, PhotoUploader
  has_many :events

  scope :with_orders, -> { where('orders_count > 0') }
  scope :by_role, ->(r) { where(:role => r) }

  validates :username, :uniqueness => {:case_sensitive => false}
  validates :email, :uniqueness => {:case_sensitive => false}
  validates :username, length: {minimum: 3}, immutable: true

  # allows user to sign in using both email and username
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  attr_accessor :login

  delegate :fake_name, :middle_name, :name, :surname, :full_name, :to_s, to: :profile

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def specialist_groups
    try(&:specialist).try(&:specialist_groups) || []
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
    role.to_s == 'guest'
  end
  def registered?
    ! guest?
  end
  def client?
    role.to_s == 'client'
  end
  def specialist?
    role.specialist?
  end
  def moderator?
    %w{admin moderator}.include?(role.to_s)
  end
  def main_moderator?
    %w{admin}.include?(role.to_s)
  end
  def admin?
    role.to_s == 'admin'
  end

  def messages
    Message.by_user(id)
  end

  def new_profile
    return if profile
    build_profile do |p|
      p.fake_name = ''
      p.middle_name = ''
      p.name = ''
      p.surname = ''
    end
  end

  def give(whom, how_many, for_order = nil)
   return false if how_many > qiwi
   Transaction.create :source => self, :destination => whom, :order => for_order, :amount => how_many
  end

  def qiwi
   transactions_in.map(&:amount).sum - transactions_out.map(&:amount).sum
  end
  def transactions
   transactions_in + transactions_out
  end

  def user
   self
  end

  #def prepare_new_profile
  # return if profile
  # #return if guest?
  # profile = Profile.new
  #end

  def phone
   profile.try(:phone)
  end

  def phone=(ph)
   profile = Profile.new unless profile
   profile.phone = ph
  end
end
