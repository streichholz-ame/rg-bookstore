ActiveAdmin.register Coupon do
  permit_params :number, :discount, :id

  index do
    selectable_column
    column :number
    column :discount
    column :order do
      Order.where(coupon_id: id)
    end

    actions
  end
end
