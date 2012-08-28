class SubAreasController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @sub_areas = SubAreaDecorator.decorate(SubArea.all)
  end

  def show
    @sub_area = SubArea.find(params[:id])
  end

  def new
    @sub_area = SubArea.new(policy_area_id: params[:policy_area_id])
  end

  def edit
    @sub_area = SubArea.find(params[:id])
  end

  def create
    @sub_area = SubArea.new(params[:sub_area])

    if @sub_area.save
      redirect_to policy_area_sub_area_path(@sub_area.policy_area, @sub_area),
        notice: 'Sub area was successfully created.'
    else
      render :new
    end
  end

  def update
    @sub_area = SubArea.find(params[:id])

    if @sub_area.update_attributes(params[:sub_area])
      redirect_to policy_area_sub_areas_url(@sub_area.policy_area), notice: 'Sub area was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @sub_area = SubArea.find(params[:id])
    @sub_area.destroy
    redirect_to policy_area_sub_areas_url(@sub_area.policy_area)
  end
end
