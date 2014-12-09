class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:update, :create]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
    render json: @memberships
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
    render json: @membershipc
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)
    @membership.status = "applying" unless membership_params[:status]

    if @membership.save
      render json: @membership, status: :created
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    if @membership.update(membership_params)
      render json: @membership, status: :ok
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:group_id, :user_id, :status)
    end
end
