class PolicyArea < ActiveRecord::Base
  has_many :sub_areas
  attr_accessible :description, :name
end
