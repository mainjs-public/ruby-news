class UploadController < ApplicationController
  def uploadImages
    uploader = ImageUploader.new(params[:path]);
    params[:file].each do |key, value|
      uploader.store!(value)
      Image.create(
          folder_id: params[:folder_id],
          name: key,
          path: "#{params[:path]}/#{key}"
      )
    end
    render json: ['1']
  end
end
