require './config/environment'


class ApplicationController < Sinatra::Base
#configuration and helper methods
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
   # SecureRandom.hex(64)
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
      @user = User.first
    end
  end
end
