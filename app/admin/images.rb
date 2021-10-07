ActiveAdmin.register Image do
  permit_params :image, :book_id

  def index
    selectable_column

    column :image do |book|
      image_tag book.photo_url
    end

    column :book_name, &:name

    actions
  end

  show do
    attributes_table do
      row :book_name, &:name

      row :image do |book|
        image_tag book.image_url(:small_image)
      end
    end
  end
end
