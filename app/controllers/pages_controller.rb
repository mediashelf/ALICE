class PagesController < ApplicationController
  expose(:page) { Page.where(slug: params[:slug]).first }
end
