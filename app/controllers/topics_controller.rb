class TopicsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
    @policy_area_id = params[:policy_area_id]
    @sub_area_id = params[:sub_area_id]
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(params[:topic])

    if @topic.save
      redirect_to @topic, notice: 'Topic was successfully created.'
    else
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update_attributes(params[:topic])
      redirect_to @topic, notice: 'Topic was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_url
  end
end
