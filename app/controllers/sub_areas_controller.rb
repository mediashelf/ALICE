class SubAreasController < ApplicationController
  def index
    @sub_areas = SubArea.all
  end

  def show
    @sub_area = SubArea.find(params[:id])
  end
end
