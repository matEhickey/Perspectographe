class WelcomeController < ApplicationController
  def welcome
    @cookie = cookies[:user_id].to_i
    @images = Array.new
    Draw.all.each{|x|
      if(!x.file.nil?)
        @images.push x
      end
    }
  end
end
