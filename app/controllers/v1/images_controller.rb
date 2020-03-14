class V1::ImagesController < ApplicationController
  def index
    @images = Image.where_params_are(params).paginate(params)
    render json: @images, status: 200
  end

  def dimensions
    render json: {dimensions: Image.all_dimensions}, status: 200
  end
end