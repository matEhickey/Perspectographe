class FollowingsController < ApplicationController
  before_action :set_following, only: [:show, :edit, :update, :destroy]
  before_action :set_cookie
  before_action :set_owner, only: [:edit, :update, :destroy]

  # GET /followings
  # GET /followings.json
  def index
    redirect_to "/"
    @followings = Following.all
  end

  # GET /followings/1
  # GET /followings/1.json
  def show
    redirect_to "/"
  end

  # GET /followings/new
  def new
    @following = Following.new
    @user = cookies[:user_id].to_i
    @follow = params[:follow].to_i

  end

  # GET /followings/1/edit
  def edit
    redirect_to "/"
  end

  # POST /followings
  # POST /followings.json
  def create
    @following = Following.new(following_params)

    respond_to do |format|
      if @following.save
        format.html { redirect_to "/", notice: 'Following was successfully created.' }
        format.json { render :show, status: :created, location: @following }
      else
        format.html { render :new }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /followings/1
  # PATCH/PUT /followings/1.json
  def update
    redirect_to "/"
    respond_to do |format|
      if @following.update(following_params)
        format.html { redirect_to @following, notice: 'Following was successfully updated.' }
        format.json { render :show, status: :ok, location: @following }
      else
        format.html { render :edit }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /followings/1
  # DELETE /followings/1.json
  def destroy
    @following.destroy
    respond_to do |format|
      format.html { redirect_to followings_url, notice: 'Vous vous avez unfollow ce membre' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_following
      @following = Following.find(params[:id])
    end

    def set_cookie
      if(cookies[:user_id].to_i == 0)
        redirect_to "/connection"
        return 0
      end
      @cookie =cookies[:user_id].to_i
    end

    def set_owner
      if(@cookie != Following.find(@following.id).user_id)
        redirect_to "/"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def following_params
      params.require(:following).permit(:user_id, :followUser_id)
    end
end
