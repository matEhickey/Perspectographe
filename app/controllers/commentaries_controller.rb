class CommentariesController < ApplicationController
  before_action :set_commentary, only: [:show, :edit, :update, :destroy]
  before_action :set_cookie
  before_action :set_owner, only: [:edit, :update, :destroy]

  # GET /commentaries
  # GET /commentaries.json
  def index
    @commentaries = User.find(@cookie).commentaries
  end

  # GET /commentaries/1
  # GET /commentaries/1.json
  def show
    redirect_to "/"
  end

  # GET /commentaries/new
  def new
    @commentary = Commentary.new
    @article = params[:article_id].to_i
    if(@article == 0)
      redirect_to "/"
    end
    @article
  end

  # GET /commentaries/1/edit
  def edit
  end

  # POST /commentaries
  # POST /commentaries.json
  def create
    @commentary = Commentary.new(commentary_params)

    respond_to do |format|
      if @commentary.save
        format.html { redirect_to @commentary, notice: 'Le commentaire a ete ajoute' }
        format.json { render :show, status: :created, location: @commentary }
      else
        format.html { render :new }
        format.json { render json: @commentary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commentaries/1
  # PATCH/PUT /commentaries/1.json
  def update
    respond_to do |format|
      if @commentary.update(commentary_params)
        format.html { redirect_to @commentary, notice: 'Commentary was successfully updated.' }
        format.json { render :show, status: :ok, location: @commentary }
      else
        format.html { render :edit }
        format.json { render json: @commentary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commentaries/1
  # DELETE /commentaries/1.json
  def destroy
    @commentary.destroy
    respond_to do |format|
      format.html { redirect_to commentaries_url, notice: 'Commentary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commentary
      @commentary = Commentary.find(params[:id])
    end

    def set_cookie
      if(cookies[:user_id].to_i == 0)
        redirect_to "/connection"
        return 0
      end
      @cookie =  cookies[:user_id].to_i
    end

    def set_owner
      if(@cookie != @commentary.user_id)
        redirect_to "/"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commentary_params
      params.require(:commentary).permit(:user_id, :article_id, :content)
    end
end
