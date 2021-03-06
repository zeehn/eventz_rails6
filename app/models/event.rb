class Event < ApplicationRecord
  before_save :set_slug

  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  # if we want to give an alias name to users so we can call likes instead of users we can do it by
  # has_many :likers, through: :likes, source: :user

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :description, length: { minimum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: 'must be a JPG or PNG image'
  }

  # def self.upcoming 
  #  where("starts_at > ?", Time.now).order("starts_at")
  # end
  scope :upcoming_events, -> { where("starts_at > ?", Time.now).order("starts_at") }
  scope :past_events, -> { where("starts_at < ?", Time.now).order("starts_at") }
  scope :free_events, -> { where(price: 0.0).order(:name) }
  scope :recent_events, -> {  where("starts_at < ?", Time.now).order("starts_at").limit(3) }
  def free?
    price.blank? || price.zero?
  end

  def sold_out?
    (capacity - registrations.size).zero?
  end

  def to_param
    slug
  end

  private
  def set_slug 
    self.slug = name.parameterize
  end
end