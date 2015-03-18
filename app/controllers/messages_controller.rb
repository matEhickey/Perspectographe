class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_cookie
  before_action :set_owner, only: [:show]
  before_action :impossible, only: [:edit]
  # GET /messages
  # GET /messages.json
  def index
    @messages = Array.new
    Message.all.each{|mess|
      if(mess.otherUser_id == @cookie)
        @messages.push(mess)
      end
    }
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
    @user = User.find(cookies[:user_id])
    if(params[:user_id].nil?)
      @to = nil
    else
      @to = User.find(params[:user_id])
    end
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    def set_cookie
      if(cookies[:user_id].to_i == 0)
        redirect_to "/connection"
        return 0
      end
      @cookie = cookies[:user_id].to_i
    end

    def set_owner
      if(@cookie != @message.user_id)&&(@cookie != @message.otherUser_id)
        redirect_to "/", notice: 'Vous n\'avez pas le droit de faire ca'
      end
    end

    def impossible
      redirect_to "/", notice: 'Vous n\'avez pas le droit de faire ca'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:user_id, :otherUser_id, :content)
    end
end
