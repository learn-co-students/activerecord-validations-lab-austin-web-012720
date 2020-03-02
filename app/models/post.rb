class Post < ActiveRecord::Base
  validates :title, presence: true 
  validates(:content, { :length => { :minimum => 250 } })   
  validates(:summary, { :length => { :maximum => 250 } })
  validates :category, inclusion: { in: ["Fiction", "Non-Fiction"]}

  validate :is_clickbait?

  def non_clickbait
    clickbait.any? self.title
    
  end

  #the /Example/ indicates a regular expression
  #the i after the / means to ignore the case
  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top [0-9]*/i,
    /Guess/i
  ]

  def is_clickbait?
    if CLICKBAIT_PATTERNS.none? do |pattern| 
      
      pattern.match title 
    end
      errors.add(:title, "must be clickbait")
    end
  end
end


