# encoding: utf-8

class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("/images/movies/cover-placeholder.jpg")

    "/images/movies/cover-placeholder.jpg"
  end

  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  version :small do
    process :resize_to_fit => [214, 317]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
