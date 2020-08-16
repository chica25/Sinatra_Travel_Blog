require './config/environment'


class ApplicationController < Sinatra::Base
#configuration and helper methods
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "The Big Lebowski" #=> Set a session secret for extra security
  end

  get '/' do
    erb :welcome
  end

  get '/login' do
    erb :'/users/login'
  end 

  helpers do   
    # code 1 
    def current_user 
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] 
      @user = User.find_by_id(session[:user_id])
    end

    # code 2 
    # def current_user #=> keeps track of the logged in user
    #   User.find_by(id: session[:user_id]
    #   #@user.find(session[:user_id])
    # end

    def user_logged_in?
        !!current_user 
    end
    
    def logout!
      session.clear
    end
  end
end
