module FacetsHelper
  include Blacklight::FacetsHelperBehavior

  # Override the default blacklight behavior to have a nbsp between the value and the count.  Just for style reasons
  def render_facet_value(facet_solr_field, item, options ={})    
    (link_to_unless(options[:suppress_link], item.value, add_facet_params_and_redirect(facet_solr_field, item.value), :class=>"facet_select label") + "&nbsp;".html_safe + render_facet_count(item.hits)).html_safe
  end
end
