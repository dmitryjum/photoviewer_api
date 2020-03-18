class V1::ImagesController < ApplicationController
  def index
    images = Image.where_params_are(params).paginate(params)
    render json: images, status: 200
  end

  def show
    image = Image.find(params[:id])
    render json: image, status: 200
  rescue ActiveRecord::RecordNotFound => e
    render json: {error: e.to_s }, status: :not_found  
  end

  def dimensions
    dimensions = {dimensions: Image.all_dimensions}
    render json: dimensions, status: 200
  end
end