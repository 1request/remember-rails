class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:update, :create]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
    render json: @locations
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    render json: @location
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    if @location.save
      render json: @location, status: :created
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    if @location.update(location_params)
      render json: @location, status: :ok
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:longitude, :latitude, :uuid, :major, :minor)
    end
end
