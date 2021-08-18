ActiveAdmin.register Book do
  decorate_with BookDecorator

  permit_params :category_id, :name, :description, :photo, :price, :publication_year, :height, :width, :depth,
                :material, author_ids: []

  filter :name
  filter :category

  index do
    selectable_column

    column :name do |book|
      link_to book.name, resource_path(book)
    end
    column :category
    column :author_name
    column :description
    column :price do |book|
      I18n.t('admin.price', price: book.price)
    end

    actions
  end

  show do
    attributes_table do
      row :name
      row :author_name
      row :description
      row :publication_year
      row :category
      row :height
      row :width
      row :depth
      row :material
      row :price do |book|
        I18n.t('admin.price', price: book.price)
      end
    end
  end

  form html: { multipart: true } do |f|
    f.inputs I18n.t('admin.edit') do
      f.input :image, as: :file
      f.input :category, as: :select
      f.input :name
      f.input :authors, as: :check_boxes, collection: Author.all.map { |author|
                                                        ["#{author.first_name} #{author.last_name}", author.id]
                                                      }
      f.input :description
      f.input :price
      f.input :publication_year
      f.input :height
      f.input :width
      f.input :depth
      f.input :material
    end
    actions
  end
end
