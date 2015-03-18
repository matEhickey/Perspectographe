class DrawsController < ApplicationController
  before_action :set_draw, only: [:show, :edit, :update, :destroy]
  before_action :set_cookie
  before_action :set_owner, only: [:edit, :update, :destroy]
  # GET /draws
  # GET /draws.json
  def index
    @draws = Draw.all
  end

  # GET /draws/1
  # GET /draws/1.json
  def show
    @b_owner = (@cookie == Article.find(@draw.postIt_id).user_id)
  end

  # GET /draws/new
  def new
    @draw = Draw.new
    @article = params[:article_id].to_i
    if(@article == 0)
      redirect_to "/"
    end
    @article
  end

  # GET /draws/1/edit
  def edit
    article = Article.find(@draw.postIt_id)
    @article = article.id
  end

  # POST /draws
  # POST /draws.json
  def create
    @draw = Draw.new(draw_params)

    respond_to do |format|
      if @draw.save
        format.html { redirect_to @draw, notice: 'Draw was successfully created.' }
        format.json { render :show, status: :created, location: @draw }
      else
        format.html { render :new }
        format.json { render json: @draw.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /draws/1
  # PATCH/PUT /draws/1.json
  def update
    respond_to do |format|
      if @draw.update(draw_params)
        format.html { redirect_to @draw, notice: 'Draw was successfully updated.' }
        format.json { render :show, status: :ok, location: @draw }
      else
        format.html { render :edit }
        format.json { render json: @draw.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /draws/1
  # DELETE /draws/1.json
  def destroy
    @draw.destroy
    respond_to do |format|
      format.html { redirect_to draws_url, notice: 'Draw was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_draw
      @draw = Draw.find(params[:id])
    end

    def set_cookie

      @cookie = cookies[:user_id].to_i
    end

    def set_owner
      if(@cookie != Article.find(@draw.postIt_id).user_id)
        redirect_to "/"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def draw_params
      params.require(:draw).permit(:postIt_id, :content)
    end
end