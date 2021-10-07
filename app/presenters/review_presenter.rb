class ReviewPresenter < ApplicationPresenter
  def all_reviews
    subject.reviews
  end

  def user_name(current_review)
    current_review.user.email.gsub(/@[a-zA-Z.]+/, '')
  end

  def date(current_review)
    current_review.created_at.strftime('%_m/%d/%y')[1..]
  end

  def approved_reviews
    all_reviews.where(status: 'published')
  end
end
