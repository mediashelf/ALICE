ActiveAdmin::Dashboards.build do
  section 'Stats' do
    ul do
      [PolicyArea, SubArea, Topic, Asset, Page].each do |model|
        li do
          pluralize(model.count, model.to_s.titleize)
        end
      end
    end
  end

  [PolicyArea, SubArea, Topic, Asset, Page].each do |model|
    name = model.to_s.titleize
    section "Recently Updated #{name.pluralize}" do
      ul do
        model.order('updated_at DESC').limit(5).each do |instance|
          li do
            link_to instance.name, polymorphic_path([:admin, instance])
          end
        end
      end
    end
  end
end
