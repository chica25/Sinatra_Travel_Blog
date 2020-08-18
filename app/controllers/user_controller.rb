require './config/environment'

class UserController < ApplicationController

    get '/signup' do
        erb :'/users/signup'
    end

    post '/signup' do 
        @user = User.new(params) 
        if @user.save
            session[:user_id] = @user.id 
            redirect '/blogs'
        else 
            flash.now[:error] = 'All fields are required.'
            #flash.now[:error] = "Account not created: #{@user.errors.full_messages.to_sentence}"
            erb :'users/signup'
        end 
    end

    # notes for -  session[:user_id] = @user.id 
    # it sets the @user’s ID to the session hash user_id
    # it saves it in the sessions hash so that they will be logged in until the user hits logout which will clear the session hash
  
    get '/login' do
       if user_logged_in?
            redirect to '/blogs'
       else
         erb :'/users/login'
        end
    end

     post '/login' do
        @user = User.find_by(email: params[:email])
       if @user && @user.authenticate(params[:password])
           session[:user_id] = @user.id
           flash[:message] = "You're in!"
           redirect '/blogs'
        else
           flash.now[:error] = 'Invalid login. Please try again.'
            erb :'/users/login'
        end
    end

    get '/users/:id' do
        redirect to '/blogs'
    end

    get '/logout' do
         logout!
         redirect to '/'
     end
 end

