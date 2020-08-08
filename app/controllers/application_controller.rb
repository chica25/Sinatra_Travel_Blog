require './config/environment'

class ApplicationController < Sinatra::Base
#configuration and helper methods
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # write sessions 
    # session ex:  enable :sessions
    # set :session_secret, "secret"
  end
 
  get '/' do
    erb :welcome
  end
helpers do 
  def current_user
      @user = User.first
    end
  end
end
