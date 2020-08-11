require './config/environment'


class ApplicationController < Sinatra::Base
#configuration and helper methods
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "dogs"
    #SecureRandom.hex(64)
  end
    # write sessions 
    # session ex:  enable :sessions

    # get '/hey' do
    #   @session = session
    # end
 
  get '/' do
    erb :welcome
  end
helpers do 
  def current_user
      @user = User.find_by_id(session[:user_id])
      #@user = User.first
    end
    def user_logged_in
      !!session[:user_id]
    end
  end
end
