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
      review.book.name
    end
    column t('admin.review.date'), :created_at
    column t('admin.review.user') do |review|
      review.user.email
    end
    column t('admin.review.review'), :review_text
    column t('admin.review.status') do |review|
      status_tag(review.status)
    end
    column t('admin.review.score'), :rating

    actions defaults: false do |review|
      links = []
      links << link_to(t('admin.review.approve'), approve_admin_review_path(review), method: :put).to_s
      links << link_to(t('admin.review.reject'), reject_admin_review_path(review), method: :put).to_s
      safe_join(links, ' ')
    end
  end

  member_action :approve, method: :put do
    resource.approve!
    redirect_back(fallback_location: admin_reviews_path,
                  notice: t('admin.review.approved'))
  end

  member_action :reject, method: :put do
    resource.reject!
    redirect_back(fallback_location: admin_reviews_path,
                  danger: t('admin.review.rejected'))
  end
end
