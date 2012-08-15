class SubArea < ActiveRecord::Base
  belongs_to :policy_area
  has_and_belongs_to_many :topics
  attr_accessible :description, :name
end
