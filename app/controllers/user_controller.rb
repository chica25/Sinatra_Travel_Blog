require './config/environment'

class UserController < ApplicationController


    #index action
    
    #new action(view for from that will create)
    get '/signup' do
        erb :'/users/signup'
    end

    # --new
    post '/users' do
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect '/blogs'
    end
    #--

    post '/signup' do
        @user = User.new(params)
        @user.save
        #binding.pry
        if @user.save
            #session[:user_id] = @user.id
            redirect '/blogs'
        else
            erb :'users/signup'
        end
    end

    get '/login' do
       if user_logged_in
            redirect '/blogs'
       else
        erb :'/users/login'
    end
end

    post '/login' do
        binding.pry
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            # binding.pry
            session[:user_id] = @user.id
            redirect '/blogs'
        else
            @error = 'Invalid login. Please try again.'
            erb :'/users/login'
        end
    end

    get '/logout' do
        if !!user_logged_in
            session.clear
            erb :"users/login"
        else   
            redirect '/'
        end
    end
end


