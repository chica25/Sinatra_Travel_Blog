require './config/environment'

class UserController < ApplicationController

    #new action(view for from that will create)
    get '/signup' do
        erb :'/users/signup'
    end


    post '/signup' do
        @user = User.new(params)
    #     if !@user.save #=> if user not save it shows error
    #         @error = @user.errors.full_messages
    #             erb :'users/signup'
    #     else
    #         session[:user_id] = @user.id
    #             redirect to '/blogs'
    #     end
    # end
        if @user.email.blank? || @user.password.blank? 
            @error = "Please sign in"
           # @error = @user.errors.full_messages
            erb :'users/signup'
        elsif User.find_by(email: params[:email]) && @user.authenticate(params[:password])
            @error = "Username already exist. Please try again"
            #@error = @user.errors.full_messages
            erb :'users/signup'
        else
            @user.save
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

     post '/login' do
        @user = User.find_by(email: params[:email])
       if @user && @user.authenticate(params[:password])
           session[:user_id] = @user.id
           redirect '/blogs'
        else
            @error = 'Invalid login. Please try again.'
            #@error = @user.errors.full_messages
            erb :'/users/login'
        end
    end

    # post '/login' do
    #     login(params[:email], params[:password])
    #     redirect to '/login'
    # end

    get '/users/:id' do
        redirect to '/blogs'
    end

    get '/logout' do
         #binding.pry
         logout!
         #binding.pry
         redirect to '/'
     end
 end
 

