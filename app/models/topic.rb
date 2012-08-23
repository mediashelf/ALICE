class Topic < ActiveRecord::Base
  attr_accessible :description, :name
  has_and_belongs_to_many :sub_areas
  validates_uniqueness_of :name
end
