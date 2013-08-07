class SpecialistGroup < ActiveRecord::Base
  has_many :specialists
  has_many :portfolio_items, through: :specialists
  has_one :avatar, as: :imageable_single, class_name: 'Photo'
  has_many :received_messages, as: :recipient, class_name: 'Message'

  has_many :orders, as: :executor

  def messages; received_messages; end

  scope :by_specialization, ->(specialization) do
    # includes, not joins because otherwise each group will be repeated several times for each specialist
    specialization.match(/^all$/i)  ?  includes(:specialists)  :  includes(:specialists).where(specialists: {specialization: specialization })
  end

  def positive_feedback; specialists.map(&:positive_feedback).inject(0,&:+); end
  def negative_feedback; specialists.map(&:negative_feedback).inject(0,&:+); end
  def neutral_feedback; specialists.map(&:neutral_feedback).inject(0,&:+); end
  def number_of_completed_orders; specialists.map(&:number_of_completed_orders).inject(0,&:+); end

  # TODO - fix this stubs with real db data
  def rating;  "Д/379 (stub)"; end
  def description; "Опыт работы: 5 лет (stub)"; end
  def to_s; name; end
  def status; :free; end # STUB!
  def free?; status == :free ? 'Свободен' : 'Занят'; end

  def specialization; specialists.first.specialization; end  # ALL specialists MUST be of the same type (specialization)
end
