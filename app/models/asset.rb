class Asset < ActiveRecord::Base
  attr_accessible :asset, :format, :keywords, :level, :policy_area, :source, :state, :sub_area, :summary, :title, :topic, :type_of, :year
  searchable do
    text :asset, :format, :keywords, :level, :policy_area, :source, :state, :sub_area, :summary, :title, :topic, :type_of, :year
    integer :year
  end
end
