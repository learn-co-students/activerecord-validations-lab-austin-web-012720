class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: { in: %w(Fiction Non-Fiction),
  message: "This is not a valid category"}
  validate :is_clickbait?
  CLICK =[
    /Won't Believe/i,
    /Secret/i,
    /Top [0-9]*/i,
    /Guess/i
  ]

  def is_clickbait?
    if CLICK.none? {|t| t.match title}
      errors.add(:title, "must be clickbait")
    end
  end
end
