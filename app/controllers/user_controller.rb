require './config/environment'

class UserController < ApplicationController
#add validations here

    #index action
    
    #new action(view for from that will create)
    get '/signup' do
        erb :'/users/signup'
    end

    post '/signup' do
        @user = User.new(params)
        if @user.save
            session[:user_id] = @user.id
            redirect to '/blogs/'
        else
            erb :'users/signup'
        end
    end

    get '/login' do
       if user_logged_in
        redirect to '/login'
       else
        erb :'/users/login'
    end
end

    post '/login' do
        user = User.find_by(email: params[:email])
        if @user && user.authenticate(params[:password])
            binding.pry
            session[:user_id] = @user.id
            redirect to '/blogs/'
        else
            @error = 'invalid login. Please try again.'
            erb :'/users/login'
        end
    end

    get '/logout' do
        if user_logged_in
            session.clear
            redirect to '/'
        end
    end
end


