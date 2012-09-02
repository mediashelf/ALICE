class ApplicationController < ActionController::Base
  include Blacklight::Controller
  before_filter :prepare_nav_links

  protect_from_forgery

  def layout_name
    'application'
  end

  def prepare_nav_links
    @nav_links = Page.where(parent_id: nil) #.order(:position)
  end
end
