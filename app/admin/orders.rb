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
end
