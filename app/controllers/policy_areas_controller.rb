class PolicyAreasController < ApplicationController
  # GET /policy_areas
  # GET /policy_areas.json
  def index
    @policy_areas = PolicyArea.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @policy_areas }
    end
  end

  # GET /policy_areas/1
  # GET /policy_areas/1.json
  def show
    @policy_area = PolicyArea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @policy_area }
    end
  end

  # GET /policy_areas/new
  # GET /policy_areas/new.json
  def new
    @policy_area = PolicyArea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @policy_area }
    end
  end

  # GET /policy_areas/1/edit
  def edit
    @policy_area = PolicyArea.find(params[:id])
  end

  # POST /policy_areas
  # POST /policy_areas.json
  def create
    @policy_area = PolicyArea.new(params[:policy_area])

    respond_to do |format|
      if @policy_area.save
        format.html { redirect_to @policy_area, notice: 'Policy area was successfully created.' }
        format.json { render json: @policy_area, status: :created, location: @policy_area }
      else
        format.html { render action: "new" }
        format.json { render json: @policy_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /policy_areas/1
  # PUT /policy_areas/1.json
  def update
    @policy_area = PolicyArea.find(params[:id])

    respond_to do |format|
      if @policy_area.update_attributes(params[:policy_area])
        format.html { redirect_to @policy_area, notice: 'Policy area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @policy_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /policy_areas/1
  # DELETE /policy_areas/1.json
  def destroy
    @policy_area = PolicyArea.find(params[:id])
    @policy_area.destroy

    respond_to do |format|
      format.html { redirect_to policy_areas_url }
      format.json { head :no_content }
    end
  end
end
