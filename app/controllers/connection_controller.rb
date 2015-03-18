class ConnectionController < ApplicationController

  before_action :set_cookie, only: [:accueil]


  def accueil

    if(@cookie == 0)
      redirect_to "/welcome"
    else
      @nbMessage = 0
      Message.all.each{|mess|
        if(User.find(@cookie).id == mess.otherUser_id)
          @nbMessage+=1
        end
      }
      @followers = Array.new
      @followings = Array.new
      Following.all.each{|x|
        if(x.followUser_id == User.find(@cookie).id)
          @followers.push(x.user_id)
        end
        if(x.user_id == User.find(@cookie).id)
          @followings.push(x.followUser_id)
        end
      }
      @images = Array.new
      @followings.each{|x|
        user = User.find(x)
        user.articles.each{|art|
          Draw.all.each{|draw|    #mauvaise methode, mais je me suis trompe a la creation des bdd sur les noms des articles, qui etaient alors des PostIt
            if(draw.postIt_id == art.id)
              if(!draw.file.nil?)
                @images.push(draw)
              end
            end
          }
        }
      }

    end
  end

  def connection
  end

  def verif
    param = params[:connection]
    email = param[:email]
    password = param[:password]
    User.all.each{|x|
      if((email == x.email)&&((Digest::MD5.hexdigest password) == x.password))
        cookies[:user_id]= x.id.to_s
        redirect_to "/"
        return 1
      end
    }
    redirect_to "/connection"
    return 0
  end

  def deconnection
    cookies.delete(:user_id)
    redirect_to "/"
  end

  private

  def set_cookie
    @cookie =  cookies[:user_id].to_i
  end



end
