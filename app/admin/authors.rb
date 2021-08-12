ActiveAdmin.register Author do
  permit_params :name

  filter :name


  index do
    selectable_column

    column :first_name
    column :last_name

    column :description

    actions
  end

  show do
    attributes_table do
      row :name
      row :description
    end
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
