class AssetsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @assets = Asset.all
  end

  def show
    @asset = Asset.find(params[:id])
  end

  def new
    @asset = Asset.new
  end

  def edit
    @asset = Asset.find(params[:id])
  end

  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      redirect_to @asset, notice: 'Asset was successfully created.'
    else
      render :new
    end
  end

  def update
    @asset = Asset.find(params[:id])
    if @asset.update_attributes(params[:topic])
      redirect_to @asset, notice: 'Topic was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
    redirect_to :assets
  end
end
