class Image < ApplicationRecord
  include Paginatable
  validates_presence_of :url
  validates_uniqueness_of :url

  scope :where_dimensions_are, -> (dimensions) {where("dimensions && ?", "{#{[dimensions].flatten.join(',')}}")}

  def self.all_dimensions
    pluck(:dimensions).flatten.uniq
  end

  def self.where_params_are params
    params[:dimensions].present? ? where_dimensions_are(params[:dimensions]) : all
  end
end