class Image < ApplicationRecord
  include Paginatable
  validates_presence_of :url
  validates_uniqueness_of :url
end