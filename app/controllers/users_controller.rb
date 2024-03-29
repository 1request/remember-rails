class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :push, :picture, :thumbnail, :groups]
  protect_from_forgery :except => [:update, :create]

  def push
     APNS.host = Settings.apns_host
    # gateway.sandbox.push.apple.com is default

    APNS.pem  = Rails.root.join(Settings.apns_path)
    # this is the file you just created

    device_token = @user.device_token

    APNS.send_notification(device_token, :alert => 'Hello iPhone!', :badge => 1, :sound => 'default',
                                         :other => {:approve_member => {:membership_id => 1}})

    render text: 'success'
  end

  def picture
    if @user.profile_picture.path.nil?
      send_file 'public/profile_pictures/original/missing.png', type: 'image/png', disposition: 'inline'
    else
      send_file @user.profile_picture.path, disposition: 'inline'
    end
  end

  def thumbnail
    if @user.profile_picture.path.nil?
      send_file 'public/profile_pictures/thumb/missing.png', type: 'image/png', disposition: 'inline'
    else
      send_file @user.profile_picture.path(:thumb), disposition: 'inline'
    end
  end

  def groups
    @memberships = @user.memberships
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
    if @user_device_token = User.find_by_device_token(user_params['device_token'])
      @user_device_token.device_token = nil
      @user_device_token.save
    end

    if @user.save
      render json: @user, status: :created
    else
      @user = User.find_by_device_id(user_params['device_id'])
      if @user
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      else
        render json: @user.errors, status: :unprocessable_entity
      end
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
