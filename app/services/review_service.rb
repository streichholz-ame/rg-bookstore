class ReviewService
  attr_reader :review_form

  def initialize(params)
    @review_form = ReviewForm.new(params)
  end

  def save_review
    create_review if review_form.valid?
  end

  private

  def create_review
    Review.create(review_attributes).save!
  end

  def review_attributes
    review_form.attributes
  end
end
