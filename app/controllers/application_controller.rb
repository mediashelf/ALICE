class ApplicationController < ActionController::Base
  include Blacklight::Controller

  protect_from_forgery

  def layout_name
    'application'
  end
end
