class Article < ApplicationRecord
  validates :title, :body, presence: true

  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments

  has_one_attached :cover_image

  has_rich_text :body

  attr_accessor :remove_cover_image

  scope :published, ->{where.not(published_at: nil)}
  scope :draft, ->{where(published_at: nil)}
  scope :recent, ->{where('published_at > ?', 1.week.ago.to_date)}
  scope :where_title, ->(term){where('articles.title LIKE ?', "%#{term}%")}

  after_save {cover_image.purge if remove_cover_image == '1'}

  def long_title
    "#{title} - #{published_at}"
  end

  def published?
    published_at.present?
  end

  def owned_by?(owner)
    return false unless owner.is_a?(User)
    owner == user
  end
end
