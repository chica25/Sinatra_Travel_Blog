require './config/environment'
require 'pry'
class UserController < ApplicationController

    #new action(view for from that will create)
    get '/signup' do
        erb :'/users/signup'
    end
    
    # -- code 1
    # post '/signup' do
    #     @user = User.create(params)
    #     session[:user_id] = @user.id
    #     redirect '/login'
    # end
    # -- code 2

    post '/signup' do
        @user = User.new(params)
        if !@user.save #=> if user not save it shows error
            @error = @user.errors.full_messages
                erb :'users/signup'
        else
            session[:user_id] = @user.id
                redirect '/blogs'
        end
    end
            
        #if @user.email.blank? || @user.password.blank? 
        #     @error = "Please sign in"
        #     erb :'users/signup'
        # elsif User.find_by(email: params[:email]) && @user.authenticate(params[:password])
        #     @error = "Username already exist. Please try again"
        #     erb :'users/signup'
        # else
        #     @user.save
        #     session[:user_id] = @user.id
        #     redirect '/blogs'
        # end
    #end
    # @errors = @volunteer.errors.full_messages
    

    get '/login' do
       if user_logged_in?
            redirect '/blogs'
       else
         erb :'/users/login'
        end
    end
    # --First code -
    # post '/login' do
    #     @user = User.find_by(email: params[:email])
    #    if @user && @user.authenticate(params[:password])
    #        session[:user_id] = @user.id
    #        redirect '/blogs'
    #     else
    #         @error = 'Invalid login. Please try again.'
    #         erb :'/users/login'
    #     end
    # end

    # ---second code --
    post '/login' do 
        @user = User.find_by(email: params[:email])
        if @user = User.find_by(email: params[:email]) && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/blogs'
        else
            params["email"].blank? || params["password"].blank?
           # @error = @user.errors.full_messages
            @error = "Invalid email and password. Please try again."
                erb :'/users/login'
        end
    end


    get '/logout' do
        # !!user_logged_in
        #session.clear
        logout!
        redirect '/'
    end
end


