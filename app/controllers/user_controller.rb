require './config/environment'

class UserController < ApplicationController

    #new action(view for from that will create)
    get '/signup' do
        erb :'/users/signup'
    end

    post '/signup' do
        @user = User.new(params)
        if @user.email.empty? || @user.password.empty?
           flash[:error] = "Please enter the right credentials"
           #binding.pry
            #@error = "Must include email and password."
            #binding.pry
            erb :'users/signup'
        elsif User.find_by(email: params[:email]) && @user.authenticate(params[:password])
            #@error = "account already exist. Please try again"
             #@error = @user.errors.full_messages
              flash[:error] = "Username already exist. Please try again."
            erb :'users/signup'
        else
            @user.save
            #session(they key), user_id(key value pair) - is assignedn to the user id
            session[:user_id] = @user.id
            redirect '/blogs'
        end
    end
  
    get '/login' do
       if user_logged_in?
            redirect to '/blogs'
       else
         erb :'/users/login'
        end
    end

    # ask Michael - Doesn't show flash error
     post '/login' do
        @user = User.find_by(email: params[:email])
       if @user && @user.authenticate(params[:password])
           session[:user_id] = @user.id
           flash[:message] = "You're in!"
           redirect '/blogs'
        else
           # @error = 'Invalid login. Please try again.'
           # @error = @user.errors.full_messages
           flash[:error] = 'Invalid login. Please try again.'
           #binding.pry
            erb :'/users/login'
        end
    end

    get '/users/:id' do
        redirect to '/blogs'
    end

    get '/logout' do
         logout!
         #binding.pry
         redirect to '/'
     end
 end
 

  # post '/login' do
    #     @user. User.where(email: params[:email]).first
    #     if @user.confirmed? and @user.auhteticate(params[:password])
    #         sessiono[:user_id] = @user.id
    #     redirect to '/login'
    #     else
    #         flash[:error] = 'Invalid login. Please try again.'
    #         erb :'/users/login'
    #     end
    # end
