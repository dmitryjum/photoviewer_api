class Image < ApplicationRecord
  include Paginatable
  validates_presence_of :url
  validates_uniqueness_of :url
  serialize :dimensions

  scope :where_dimensions_are, -> (dimensions) {where("dimensions && ?", "{#{[dimensions].flatten.join(',')}}")}

  def self.all_dimensions
    pluck(:dimensions).flatten.uniq
  end
end