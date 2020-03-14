class Image < ApplicationRecord
  include Paginatable
  validates_presence_of :url
  validates_uniqueness_of :url

  def self.all_dimensions
    Image.pluck(:dimensions).flatten.uniq
  end
end