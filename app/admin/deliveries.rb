ActiveAdmin.register Delivery do
  permit_params :name, :price, :days_min, :days_max

  filter :name
  filter :price
  filter :days_min
  filter :days_max

  index do
    selectable_column

    column :name
    column :price
    column :days_min
    column :days_max

    actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :days_min
      row :days_max
    end
  end
end
