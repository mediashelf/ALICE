class TopicsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_parents, except: [:index, :show]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(params[:topic])

    if @topic.save
      redirect_to url_for([@policy_area, @sub_area, @topic]), notice: 'Topic was successfully created.'
    else
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update_attributes(params[:topic])
      redirect_to url_for([@policy_area, @sub_area, @topic]), notice: 'Topic was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to policy_area_sub_area_topics_path(@policy_area, @sub_area)
  end

  private

  def find_parents
    @policy_area = PolicyArea.find(params[:policy_area_id])
    @sub_area = SubArea.find(params[:sub_area_id])
  end

end
