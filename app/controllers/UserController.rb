class UserController < ApplicationController
#add validations here

    #index action
    get '/user' do
        @user = User.create(name: "name", email: "email", password: "password")
        erb ':user/index'
    end
    #new action(view for from that will create)

    #create action

    #show action

    #edit action(view for form that will update)

    #update action

    #delete action
end