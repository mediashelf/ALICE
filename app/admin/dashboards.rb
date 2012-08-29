ActiveAdmin::Dashboards.build do
  section 'Stats' do
    ul do
      li do
        "#{PolicyArea.count} Policy Areas"
      end
      li do
        "#{SubArea.count} Sub Areas"
      end
      li do
        "#{Topic.count} Topics"
      end
      li do
        "#{Asset.count} Assets"
      end
    end
  end

  section 'Recently Updated Topics' do
    ul do
      Topic.order('updated_at DESC').limit(5).each do |topic|
        li do
          link_to topic.name, admin_topic_path(topic)
        end
      end
    end
  end

  section 'Recently Updated Sub Areas' do
    ul do
      SubArea.order('updated_at DESC').limit(5).each do |sub_area|
        li do
          link_to sub_area.name, admin_sub_area_path(sub_area)
        end
      end
    end
  end
  section 'Recently Updated Policy Areas' do
    ul do
      PolicyArea.order('updated_at DESC').limit(5).each do |policy_area|
        li do
          link_to policy_area.name, admin_policy_area_path(policy_area)
        end
      end
    end
  end

end
