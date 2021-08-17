class ReviewPresenter
  attr_reader :current_book

  def initialize(current_book)
    @current_book = current_book
  end

  def all_reviews
    current_book.reviews
  end

  def user_name(current_review)
    User.find(current_review.user_id).email.gsub(/@[a-zA-Z.]+/, '')
  end

  def date(current_review)
    current_review.created_at.strftime('%_m/%d/%y')[1..]
  end

  def approved_reviews
    all_reviews.where(status: 'published')
  end
end
