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
            erb :'users/signup'
        end 
    end
  
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

