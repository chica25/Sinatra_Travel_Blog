require './config/environment'
require 'pry'
class UserController < ApplicationController

    #new action(view for from that will create)
    get '/signup' do
        erb :'/users/signup'
    end

    # --new
    # post '/users' do
    #     @user = User.create(params)
    #     session[:user_id] = @user.id
    #     redirect '/login'
    #end
    post '/signup' do
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect '/login'
    end

    get '/login' do
       if user_logged_in
            redirect '/blogs'
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
            erb :'/users/login'
        end
    end

    get '/logout' do
        # !!user_logged_in
        session.clear
        redirect '/login'
    end
end


