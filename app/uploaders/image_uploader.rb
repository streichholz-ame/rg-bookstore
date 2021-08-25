class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog

  storage :file if Rails.env.test?

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :small_image do
    process resize_to_fill: [170, nil]
  end
  version :medium_image do
    process resize_to_fill: [200, 300]
  end
  version :big_image do
    process resize_to_fill: [400, 500]
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
