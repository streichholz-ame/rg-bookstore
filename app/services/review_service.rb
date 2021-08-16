class ReviewService
  attr_reader :review_form

  def initialize(params)
    @review_form = ReviewForm.new(params)
  end

  def save_review
    create_review if review_form.valid?
  end

  def create_review
    Review.create(review_attributes)
  end

  def review_attributes
    review_form.attributes
  end
end