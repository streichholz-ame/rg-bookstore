class ReviewsController < ApplicationController
  def create
    review_service = ReviewService.new(review_params)
    @review_form = review_service.review_form
    if review_service.save_review
      flash[:success] = t('flash.review')
    else
      flash[:error] = @review_form.errors.full_messages.to_sentence
    end
    redirect_to book_path(params[:book_id])
  end

  private

  def review_params
    params.require(:review).permit(:title, :review_text, :rating, :user_id, :book_id)
  end
end
