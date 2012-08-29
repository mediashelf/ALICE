class ApplicationController < ActionController::Base
  include Blacklight::Controller
  before_filter :show_hierarchy

  protect_from_forgery

  def layout_name
    'application'
  end

  def show_hierarchy
    @show_hierarchy = true
    @policy_areas = PolicyArea.all
  end
end
