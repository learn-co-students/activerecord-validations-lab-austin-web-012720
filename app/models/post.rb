class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :validate_clickbait?

  def validate_clickbait?
    clickbait_words = [/won't believe/, /secret/, /guess/, /top [0-9]*/]
    if !title.presence || clickbait_words.none?{ |phrase| phrase.match(title.downcase) }
      errors.add(:title, "must be clickbait")
    end
  end
end
