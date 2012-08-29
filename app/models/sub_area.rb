class SubArea < ActiveRecord::Base
  belongs_to :policy_area
  has_and_belongs_to_many :topics
  attr_accessible :description, :name, :policy_area_id
  validates_uniqueness_of :name

  def select_formatted_name
    "#{self.policy_area.name} &rsaquo; #{self.name}".html_safe
  end
end
