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
      redirect_to @asset
    else
      render new
    end
  end

  def update
    @asset = Asset.find(params[:id])
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
  end
end
