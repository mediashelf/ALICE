class SubArea < ActiveRecord::Base
  belongs_to :policy_area
  attr_accessible :description, :name
end
