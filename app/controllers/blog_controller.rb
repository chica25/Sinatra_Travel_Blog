require './config/environment'

class BlogController < ApplicationController
 
 # index action
  get '/blogs' do
      @blogs = current_user.blogs #=> shows who is the current user
      erb :'blogs/index'
  end

  # new action(view form that will create)
  get '/blogs/new' do
    erb :'blogs/new'
  end

  # create action
  post '/blogs' do
    @blog = Blog.create(title: params[:title], location: params[:location], description: params[:description], image_url: params[:image_url])
    redirect "/blogs/#{@blog.id}" #=> a response to the original post request
  end

  # show action
  get '/blogs/:id' do
    @blog = Blog.find_by_id(params[:id])
    if @blog 
      erb :'blogs/show'
    else
      redirect '/blogs'
    end
  end

  # edit action(view for form that will update)
  get 'blogs/:id/edit' do
    
  end

  # update action

end



  


