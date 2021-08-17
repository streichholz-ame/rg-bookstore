ActiveAdmin.register Author do
  permit_params :first_name, :last_name, :description

  filter :first_name
  filter :last_name

  index do
    selectable_column

    column :first_name
    column :last_name

    column :description

    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :description
    end
  end
end
