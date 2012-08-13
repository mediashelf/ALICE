class SubAreasController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  # GET /sub_areas
  # GET /sub_areas.json
  def index
    @sub_areas = SubArea.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sub_areas }
    end
  end

  # GET /sub_areas/1
  # GET /sub_areas/1.json
  def show
    @sub_area = SubArea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sub_area }
    end
  end

  # GET /sub_areas/new
  # GET /sub_areas/new.json
  def new
    @sub_area = SubArea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sub_area }
    end
  end

  # GET /sub_areas/1/edit
  def edit
    @sub_area = SubArea.find(params[:id])
  end

  # POST /sub_areas
  # POST /sub_areas.json
  def create
    @sub_area = SubArea.new(params[:sub_area])

    respond_to do |format|
      if @sub_area.save
        format.html { redirect_to @sub_area, notice: 'Sub area was successfully created.' }
        format.json { render json: @sub_area, status: :created, location: @sub_area }
      else
        format.html { render action: "new" }
        format.json { render json: @sub_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sub_areas/1
  # PUT /sub_areas/1.json
  def update
    @sub_area = SubArea.find(params[:id])

    respond_to do |format|
      if @sub_area.update_attributes(params[:sub_area])
        format.html { redirect_to @sub_area, notice: 'Sub area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sub_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_areas/1
  # DELETE /sub_areas/1.json
  def destroy
    @sub_area = SubArea.find(params[:id])
    @sub_area.destroy

    respond_to do |format|
      format.html { redirect_to sub_areas_url }
      format.json { head :no_content }
    end
  end
end
