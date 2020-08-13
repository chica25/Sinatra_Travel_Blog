require './config/environment'


class ApplicationController < Sinatra::Base
#configuration and helper methods
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "Dogs"
  end

  get '/' do
    erb :welcome
  end

  get '/login' do
    erb :'/users/login'
end

  helpers do    
    def current_user 
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] 
      #@user = User.find_by_id(session[:user_id])
    end
      def user_logged_in
        !!current_user 
      end
    end
  end
