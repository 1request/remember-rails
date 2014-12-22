class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:update, :destory, :create]

  # GET /groups
  # GET /groups.json
  def index
    @groups = if params[:user_id] && params[:status]
      Group.joins(:memberships)
        .where("memberships.user_id = ?", params[:user_id])
        .where("memberships.status = ?", params[:status])
    elsif params[:lat] && params[:lng]
      range = if params[:range] then params[:range] else 10 end
      Group.joins(:location).near([params[:lat], params[:lng]], range, :units => :km)
    else
      Group.all
    end
    render json: @groups.as_json(params: params)
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    render json: @group.as_json(params: params, list_users: true)
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @group.private = true

    if !location_params.empty?
      location = Location.where(
        longitude: location_params[:longitude],
        latitude:  location_params[:latitude],
        uuid:      location_params[:uuid],
        major:     location_params[:major],
        minor:     location_params[:minor],        
      ).first
      location = Location.create(location_params) if !location
      @group.location_id = location.id
    end

    if @group.save
      render json: @group, status: :created
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    if @group.update(group_params)
      render json: @group, status: :ok
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :private, :location_id, :creator_id)
    end

    def location_params
      params.permit(:longitude, :latitude, :uuid, :major, :minor)
    end
end
