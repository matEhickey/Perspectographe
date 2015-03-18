class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_cookie
  before_action :set_owner, only: [:edit, :update, :destroy]
  # GET /articles
  # GET /articles.json
  def index
    @articles = Array.new
    @my_art = Array.new

    Article.all.each{|art|
      if(art.user_id == @cookie)
        @my_art.push art
      else
        @articles.push art
      end
    }
    #uniquement les articles qui appartiennent a l'utilisateur
  end

  # GET /articles/1
  # GET /articles/1.json
  def show

    @draws = Array.new
    Draw.all.each{|draw|
      if(draw.postIt_id == @article.id)
        @draws.push draw
      end
    }

    @tips = Array.new
    Tip.all.each{|tip|
      if(tip.postIt_id == @article.id)
        @tips.push tip
      end
    }
    @params = params #debug
    @b_owner = (@cookie == @article.user_id)

  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    if(!@b_owner)

    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "L'article a ete correctement cree" }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'L\'article a ete correctement mis a jour' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Vous avez bien detruit cet article' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_cookie
      if(cookies[:user_id].to_i == 0)
        redirect_to "/connection"
        return 0
      end
      @cookie = cookies[:user_id].to_i
    end

    def set_owner
      @b_owner = (Article.find(@article).user_id == @cookie)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:user_id, :name)
    end
end
