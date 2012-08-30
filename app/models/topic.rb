class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :sub_area_ids
  has_and_belongs_to_many :assets
  has_and_belongs_to_many :sub_areas
  validates_uniqueness_of :name
end
