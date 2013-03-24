class ReplanningEndorsementsController < ApplicationController
  # GET /replanning_endorsements
  # GET /replanning_endorsements.json
  def index
    @replanning_endorsements = ReplanningEndorsement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @replanning_endorsements }
    end
  end

  # GET /replanning_endorsements/1
  # GET /replanning_endorsements/1.json
  def show
    @replanning_endorsement = ReplanningEndorsement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @replanning_endorsement }
    end
  end

  # GET /replanning_endorsements/new
  # GET /replanning_endorsements/new.json
  def new
    @replanning_endorsement = ReplanningEndorsement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @replanning_endorsement }
    end
  end

  # GET /replanning_endorsements/1/edit
  def edit
    @replanning_endorsement = ReplanningEndorsement.find(params[:id])
  end

  # POST /replanning_endorsements
  # POST /replanning_endorsements.json
  def create
    @replanning_endorsement = ReplanningEndorsement.new(params[:replanning_endorsement])

    respond_to do |format|
      if @replanning_endorsement.save
        format.html { redirect_to @replanning_endorsement, notice: 'Replanning endorsement was successfully created.' }
        format.json { render json: @replanning_endorsement, status: :created, location: @replanning_endorsement }
      else
        format.html { render action: "new" }
        format.json { render json: @replanning_endorsement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /replanning_endorsements/1
  # PUT /replanning_endorsements/1.json
  def update
    @replanning_endorsement = ReplanningEndorsement.find(params[:id])

    respond_to do |format|
      if @replanning_endorsement.update_attributes(params[:replanning_endorsement])
        format.html { redirect_to @replanning_endorsement, notice: 'Replanning endorsement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @replanning_endorsement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replanning_endorsements/1
  # DELETE /replanning_endorsements/1.json
  def destroy
    @replanning_endorsement = ReplanningEndorsement.find(params[:id])
    @replanning_endorsement.destroy

    respond_to do |format|
      format.html { redirect_to replanning_endorsements_url }
      format.json { head :no_content }
    end
  end
end
