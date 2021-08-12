ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column
    column :name

    actions
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
