class ImageController < ApplicationController
  before_action :set_cookie

  def new
    @param_draw = @params[:draw_id].to_i

  end

  def upload

  	@param_image = @params[:image][:image]
    @param_draw = @params[:image][:draw_id].to_i
  	@io = @param_image.to_io
  	@chemin = Rails.root.join('app', 'assets','images','photos', @param_image.original_filename)
  	File.open(@chemin, 'wb') do |file|
       file.write(@param_image.read)
     end

     a = Draw.find(@param_draw)
     a.file = @param_image.original_filename
     if(!a.save)
       redirect_to "/image/new/#{@param_draw}"
     end
  end

  private
  def set_cookie
    @cookie = cookies[:user_id].to_i
    @params = params


    if(@cookie == 0)
      redirect_to "/"
    end


  end

end
