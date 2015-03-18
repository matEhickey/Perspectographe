class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_cookie, except:[:new,:create]
  before_action :set_owner, except: [:index, :show,:new,:create]
  # GET /users
  # GET /users.json
  def index
    @users = User.all

  end

  # GET /users/1
  # GET /users/1.json
  def show
    
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
    @user.password = Digest::MD5.hexdigest @user.password

    respond_to do |format|
      if @user.save
        format.html { redirect_to "/welcome", notice: "Le compte a bien ete cree, vous pouvez desormais vous connecter" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Le compte a bien ete mis a jour' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to "/deconnection", notice: 'Votre compte a bien ete detruit' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_cookie
      if(cookies[:user_id].to_i == 0)
        redirect_to "/connection"
        return 0
      end
      @cookie =   cookies[:user_id].to_i
    end

    def set_owner
      if(@cookie != (@user.id))
        redirect_to "/", notice: 'Vous n\'avez pas le droit de faire ca'
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:pseudo, :password, :firstname, :name, :email, :age)
    end
end
