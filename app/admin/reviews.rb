ActiveAdmin.register Review do
  permit_params :title, :review_text, :text, :rating, :user_id, :book_id, :status

  filter :book

  scope :all
  scope :processing, -> { where(status: 'processing') }
  scope :published, -> { where(status: 'published') }
  scope :rejected, -> { where(status: 'rejected') }

  index do
    selectable_column
    column t('admin.review.title') do |review|
      Book.find(review.book_id).name
    end
    column t('admin.review.date'), :created_at
    column t('admin.review.user') do |review|
      User.find(review.user_id).email
    end
    column t('admin.review.review'), :review_text
    column t('admin.review.status') do |review|
      status_tag(review.status)
    end
    column t('admin.review.score'), :rating

    column do |review|
      (link_to t('admin.review.approve'),
               approve_admin_review_path(review), method: :put) + ' - ' +
        (link_to t('admin.review.reject'),
                 reject_admin_review_path(review), method: :put)
    end
  end

  member_action :approve, method: :put do
    review = Review.find(params[:id])
    review.approve!
    redirect_back(fallback_location: admin_reviews_path,
                  notice: t('admin.review.approved'))
  end

  member_action :reject, method: :put do
    review = Review.find(params[:id])
    review.reject!
    redirect_back(fallback_location: admin_reviews_path,
                  danger: t('admin.review.rejected'))
  end
end
