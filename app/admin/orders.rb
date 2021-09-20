ActiveAdmin.register Order do
  permit_params :user_id, :coupon_id, :status, :number

  filter :status

  scope :all
  scope :processing, -> { where(status: 'complete') }
  scope :in_delivery, -> { where(status: 'in_delivery') }
  scope :delivered, -> { where(status: 'delivered') }
  scope :canceled, -> { where(status: 'canceled') }

  index do
    selectable_column
    column :user_id
    column :coupon_id
    column :status
    column :number

    column do |order|
      (link_to t('admin.orders.canceled'),
               cancel_admin_order_path(order),
               method: :put) + ' - ' + (link_to t('admin.orders.in_delivery'),
                                                set_in_delivery_admin_order_path(order),
                                                method: :put) + ' - ' + (link_to t('admin.orders.delivered'),
                                                                                 deliver_admin_order_path(order),
                                                                                 method: :put)
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
  end

  member_action :cancel, method: :put do
    order = Order.find(params[:id])
    order.cancel!
    redirect_back(fallback_location: admin_reviews_path,
                  notice: t('admin.orders.canceled'))
  end

  member_action :set_in_delivery, method: :put do
    order = Order.find(params[:id])
    order.set_in_delivery!
    redirect_back(fallback_location: admin_reviews_path,
                  notice: t('admin.orders.in_delivery'))
  end

  member_action :deliver, method: :put do
    order = Order.find(params[:id])
    order.deliver!
    redirect_back(fallback_location: admin_reviews_path,
                  notice: t('admin.orders.delivered'))
  end
end
