class AudiosController < ApplicationController
  before_action :set_audio, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:update, :create]

  # GET /audios
  # GET /audios.json
  def index
    @audios = if params[:group_id]
      Audio.where(group_id: params[:group_id])
    else
      Audio.all
    end
    render json: @audios
  end

  # GET /audios/1
  # GET /audios/1.json
  def show
    render json: @audio
  end

  # GET /audios/new
  def new
    @audio = Audio.new
  end

  # GET /audios/1/edit
  def edit
  end

  # POST /audios
  # POST /audios.json
  def create
    @audio = Audio.new(audio_params)

    if @audio.save
      render json: @audio, status: :created
    else
      render json: @audio.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /audios/1
  # PATCH/PUT /audios/1.json
  def update
    if @audio.update(audio_params)
      render json: @audio, status: :ok
    else
      render json: @audio.errors, status: :unprocessable_entity
    end
  end

  # DELETE /audios/1
  # DELETE /audios/1.json
  def destroy
    @audio.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audio
      @audio = Audio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audio_params
      params.require(:audio).permit(:group_id, :user_id, :audioclip)
    end
end
