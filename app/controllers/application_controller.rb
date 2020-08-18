require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "The Big Lebowski"
     register Sinatra::Flash
  end

  get '/' do
    if user_logged_in?
      redirect to "/blogs/#{@current_user.id}"
    else      
      erb :welcome
  end
end

  helpers do   
    def current_user 
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] 
      @user = User.find_by_id(session[:user_id])
    end
  end

    def user_logged_in?
        !!current_user 
    end

    def logout!
      session.clear
    end
  end

  