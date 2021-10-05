ActiveAdmin.register Order do
  permit_params :user_id, :coupon_id, :status, :number

  filter :status

  scope :all
  scope :complete, -> { where(status: 'complete') }
  scope :in_delivery, -> { where(status: 'in_delivery') }
  scope :delivered, -> { where(status: 'delivered') }
  scope :canceled, -> { where(status: 'canceled') }

  index do
    selectable_column
    column :user_id
    column :coupon_id
    column :status
    column :number
    actions defaults: false do |order|
      links = []
      links << link_to(t('admin.orders.canceled'), cancel_admin_order_path(order), method: :put).to_s
      links << link_to(t('admin.orders.in_delivery'), set_in_delivery_admin_order_path(order), method: :put).to_s
      links << link_to(t('admin.orders.delivered'), deliver_admin_order_path(order), method: :put).to_s
      safe_join(links, ' ')
    end
    actions
  end

  show do
    attributes_table do
      row :order_items
      row :status
      row :number
    end
  end

  form html: { multipart: true } do |f|
    f.inputs I18n.t('admin.edit') do
      f.input :status
    end
    actions
  end

  member_action :cancel, method: :put do
    resource.cancel!
    redirect_back(fallback_location: admin_reviews_path,
                  notice: t('admin.orders.canceled'))
  end

  member_action :set_in_delivery, method: :put do
    resource.set_in_delivery!
    redirect_back(fallback_location: admin_reviews_path,
                  notice: t('admin.orders.in_delivery'))
  end

  member_action :deliver, method: :put do
    resource.deliver!
    redirect_back(fallback_location: admin_reviews_path,
                  notice: t('admin.orders.delivered'))
  end
end
