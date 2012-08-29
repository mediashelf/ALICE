class PolicyAreasController < ApplicationController
  def index
    @policy_areas = PolicyArea.all
  end

  def show
    @policy_area = PolicyArea.find(params[:id])
  end
end
