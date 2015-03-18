class PostItsController < ApplicationController
  before_action :set_post_it, only: [:show, :edit, :update, :destroy]

  # GET /post_its
  # GET /post_its.json
  def index
    @cookie = cookies[:user_id].to_i
    @post_its = Array.new
    PostIt.all.each{|pi|
      if(pi.user_id == @cookie)
        @post_its.push(pi)
      end
    }
  end

  # GET /post_its/1
  # GET /post_its/1.json
  def show
    if(cookies[:user_id].to_i != 0)
      @cookie = cookies[:user_id].to_i
    end
    @drawings = Array.new
    Drawing.all.each{|x|
      if(x.postIt_id == @post_it.id)
        @drawings.push(x)
      end
    }
    @tips = Array.new
    Tip.all.each{|x|
      if(x.PostIt_id == @post_it.id)
        @tips.push(x)
      end
    }
  end

  # GET /post_its/new
  def new

    @post_it = PostIt.new


  end

  # GET /post_its/1/edit
  def edit

    if(cookies[:user_id].to_i != @post_it.user_id)
      redirect_to post_its_path, notice: 'Vous n\'etes pas proprietaire de ce contenu'
    end
  end

  # POST /post_its
  # POST /post_its.json
  def create
    @post_it = PostIt.new(post_it_params)

    respond_to do |format|
      if @post_it.save
        format.html { redirect_to @post_it, notice: 'Post it was successfully created.' }
        format.json { render :show, status: :created, location: @post_it }
      else
        format.html { render :new }
        format.json { render json: @post_it.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_its/1
  # PATCH/PUT /post_its/1.json
  def update
    getCookie
    respond_to do |format|
      if @post_it.update(post_it_params)
        format.html { redirect_to @post_it, notice: 'Post it was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_it }
      else
        format.html { render :edit }
        format.json { render json: @post_it.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_its/1
  # DELETE /post_its/1.json
  def destroy
    getCookie
    @post_it.destroy
    respond_to do |format|
      format.html { redirect_to post_its_url, notice: 'Post it was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_it
      @post_it = PostIt.find(params[:id])
    end

    def getCookie
        set_post_it
        if(cookies[:user_id].to_i == 0)
          redirect_to "/connection"
          return 0
        end
        @cookie = cookies[:user_id].to_i
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_it_params
      params.require(:post_it).permit(:user_id, :subject_id)
    end
end
