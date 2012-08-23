class PolicyArea < ActiveRecord::Base
  has_many :sub_areas
  attr_accessible :description, :name
  validates_uniqueness_of :name
end
