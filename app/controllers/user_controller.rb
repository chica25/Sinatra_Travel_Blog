require './config/environment'

class UserController < ApplicationController
#add validations here

    #index action
    
    #new action(view for from that will create)
    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        #binding.pry
        @user = User.new(params)
        if @user.save
            session[:user_id] = @user.id
            redirect to '/blogs'
        else
            erb :'/users/signup'
        end
    end

    get '/login' do
       if user_logged_in
        redirect to '/blogs'
       else
        erb :'users/login'
    end
end

    post '/login' do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/blogs'
        else
            @error = 'invalid login. Please try again'
            erb :'users/login'
        end
    end

        get '/logout' do
            if user_logged_in
            session.clear
            #session.destroy
            redirect to '/'
        end
    end
end


    #create action
    # post '/users/new' do
        
    #     @user = User.new(params)
    #     if @user.save
    #         #set session
    #         redirect to :'user/index'
    #     else
    #         erb :'user/new'
    #     end
    #end

    #show action

    #edit action(view for form that will update)

    #update action

    #delete action


