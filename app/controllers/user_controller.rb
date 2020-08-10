require './config/environment'

class UserController < ApplicationController
#add validations here

    #index action
    
    #new action(view for from that will create)
    get '/signup' do
        erb :'users/signup'
    end
    #create action
    post '/users/new' do
        
        @user = User.new(params)
        if @user.save
            #set session
            redirect to :'user/index'
        else
            erb :'user/new'
        end
    end

    #show action

    #edit action(view for form that will update)

    #update action

    #delete action
end

