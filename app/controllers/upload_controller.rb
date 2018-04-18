class UploadController < ApplicationController
  def uploadImages
    uploader = ImageUploader.new(params[:dir]);
    params[:file].each do |key, value|
      uploader.store!(value)
      image = Image.new
      image.name = key
      image.path = params[:dir]
      image.save

      puts image

    end
    render json: ['1']
  end
end
