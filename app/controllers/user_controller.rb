require './config/environment'
require 'pry'
class UserController < ApplicationController

    #new action(view for from that will create)
    get '/signup' do
        erb :'/users/signup'
    end
    
    # post '/signup' do
    #     @user = User.create(params)
    #     session[:user_id] = @user.id
    #     redirect '/login'
    # end

    post '/signup' do
        @user = User.new(params)
        if @user.user_name.blank? || @user.password.blank?
            @error = "Please sign in"
            erb :'users/signup'
        else
            @user.save
            session[:user_id] = @user.id
            redirect '/blogs'
        end
    end

    get '/login' do
       if user_logged_in
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
            @error = "Invalid email and password. Please try again."
                erb :'/users/login'
        end
    end

    get '/logout' do
        # !!user_logged_in
        session.clear
        redirect '/login'
    end
end


