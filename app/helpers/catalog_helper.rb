module CatalogHelper
  include Blacklight::CatalogHelperBehavior

  def has_search_parameters?
    super or params[:f_inclusive].present?
  end

end
