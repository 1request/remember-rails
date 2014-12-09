class GroupUsersController < ApplicationController
  before_action :set_group_user, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:update, :create]

  # GET /group_users
  # GET /group_users.json
  def index
    @group_users = GroupUser.all
    render json: @group_users
  end

  # GET /group_users/1
  # GET /group_users/1.json
  def show
    render json: @group_userc
  end

  # GET /group_users/new
  def new
    @group_user = GroupUser.new
  end

  # GET /group_users/1/edit
  def edit
  end

  # POST /group_users
  # POST /group_users.json
  def create
    @group_user = GroupUser.new(group_user_params)
    @group_user.status = "applying" unless group_user_params[:status]

    if @group_user.save
      render json: @group_user, status: :created
    else
      render json: @group_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /group_users/1
  # PATCH/PUT /group_users/1.json
  def update
    if @group_user.update(group_user_params)
      render json: @group_user, status: :ok
    else
      render json: @group_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_users/1
  # DELETE /group_users/1.json
  def destroy
    @group_user.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_user
      @group_user = GroupUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_user_params
      params.require(:group_user).permit(:group_id, :user_id, :status)
    end
end
