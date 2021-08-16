class ReviewsController < ApplicationController
  def create
    review_service = ReviewService.new(review_params)
    @review_form = review_service.review_form
    if review_service.save_review
      flash[:success] = 'success'
    else
      flash[:error] = @comment_form.errors.full_messages.to_sentence
    end 
    redirect_to book_path(params[:book_id])
  end

  def review_params
    params.permit(:title, :review_text, :rating, :current_user, :current_book)
  end
end
