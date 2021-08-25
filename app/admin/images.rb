ActiveAdmin.register Image do
  permit_params :image, :book_id

  def index
    selectable_column

    column :image do |book|
      image_tag book.photo_url
    end

    column :book_id do |book|
      Book.find_by(id: Image.find_by(id: book.id.to_i).book_id)
    end

    actions
  end

  show do
    attributes_table do
      row :book_id do |book|
        Book.find_by(id: Image.find_by(id: book.id.to_i).book_id)
      end

      row :image do |book|
        image_tag book.image_url(:small_image)
      end
    end
  end
end
