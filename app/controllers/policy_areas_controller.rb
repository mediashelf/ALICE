class PolicyAreasController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @policy_areas = PolicyArea.all
  end

  def show
    @policy_area = PolicyArea.find(params[:id])
  end

  def new
    @policy_area = PolicyArea.new
  end

  def edit
    @policy_area = PolicyArea.find(params[:id])
  end

  def create
    @policy_area = PolicyArea.new(params[:policy_area])

    if @policy_area.save
      redirect_to @policy_area, notice: 'Policy area was successfully created.'
    else
      render :new
    end
  end

  def update
    @policy_area = PolicyArea.find(params[:id])

    if @policy_area.update_attributes(params[:policy_area])
      redirect_to @policy_area, notice: 'Policy area was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @policy_area = PolicyArea.find(params[:id])
    @policy_area.destroy

    redirect_to policy_areas_url
  end
end
