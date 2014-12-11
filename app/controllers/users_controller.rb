class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :push]
  protect_from_forgery :except => [:update, :create]

  def push
     APNS.host = 'gateway.push.apple.com'
    # gateway.sandbox.push.apple.com is default

    APNS.pem  = Rails.root.join('config/settings/cert.pem')
    # this is the file you just created

    APNS.port = 2195
    # this is also the default. Shouldn't ever have to set this, but just in case Apple goes crazy, you can.

    device_token = @user.device_token

    APNS.send_notification(device_token, :alert => 'Hello iPhone!', :badge => 1, :sound => 'default',
                                         :other => {:approve_member => {:membership_id => 1}})

    render text: 'success'
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:device_id, :device_token, :device_type, :nickname, :profile_picture)
    end
end
