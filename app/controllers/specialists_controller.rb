class SpecialistsController < ApplicationController

  before_filter :authenticate_user!, except: [:index]

  # GET /specialists
  # GET /specialists.json
  def index
    specialist_type = params[:specialist_type]
    
    if !specialist_type || specialist_type.blank? || specialist_type == :all
      @specialists = Specialist.all
    else
      @specialists = Specialist.where(specialist_type: Specialist::SPECIALIST_TYPE_ID_BY_NAME[specialist_type])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @specialists }
    end
  end

  # GET /specialists/1
  # GET /specialists/1.json
  def show
    @specialist = Specialist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @specialist }
    end
  end

  # GET /specialists/new
  # GET /specialists/new.json
  def new
    @specialist = Specialist.new
    @specialist.profile = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @specialist }
    end
  end

  # GET /specialists/1/edit
  def edit
    @specialist = Specialist.find(params[:id])
  end

  # POST /specialists
  # POST /specialists.json
  def create
    @specialist = Specialist.new(params[:specialist])
    @specialist.profile = current_user

    respond_to do |format|
      if @specialist.save
        format.html { redirect_to @specialist, notice: 'Specialist was successfully created.' }
        format.json { render json: @specialist, status: :created, location: @specialist }
      else
        format.html { render action: "new" }
        format.json { render json: @specialist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /specialists/1
  # PUT /specialists/1.json
  def update
    @specialist = Specialist.find(params[:id])

    respond_to do |format|
      if @specialist.update_attributes(params[:specialist])
        format.html { redirect_to @specialist, notice: 'Specialist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @specialist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specialists/1
  # DELETE /specialists/1.json
  def destroy
    @specialist = Specialist.find(params[:id])
    @specialist.destroy

    respond_to do |format|
      format.html { redirect_to specialists_url }
      format.json { head :no_content }
    end
  end
end
