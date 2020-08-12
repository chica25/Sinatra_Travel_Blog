require './config/environment'

class BlogController < ApplicationController
 
 # index action
  get '/blogs' do
     @user = current_user
     @blogs = Blog.all #=> shows who is the current user
      erb :'/blogs/index'
    end

  # new action(view form that will create)
  get '/blogs/new' do
    @message = session[:message]
    erb :'/blogs/new'
  end

  # create action
  post '/blogs' do
    @blog = current_user.blogs.create(title: params[:title], location: params[:location], description: params[:description], image_url: params[:image_url])
    redirect to "/blogs/#{@blog.id}" #=> a response to the original post request
  end


  # show action
  get '/blogs/:id' do
    @message = session[:message]
    @blog = Blog.find_by_id(params[:id])
    if @blog 
      erb :'/blogs/show'
    else
      redirect to '/blogs/'
    end
  end

  # edit action(view for form that will update)
  get '/blogs/:id/edit' do
    @blog = Blog.find_by_id(params[:id])
    erb :'blogs/edit'
  end

  patch '/blogs/:id' do
    @blog = Blog.find_by_id(params[:id])
    params.delete(:_method)
    @blog.update(params)
    redirect to "/blogs/#{@blog.id}"
    end 
  
  
  # delete action
  # side note - Users can only delete records that belong to them
  #delete '/blogs/:id' do

#     delete '/blogs/:id' do
#     @blog = Blog.find_by_id(params[:id])
#     @blog.destroy
#     redirect '/blogs'
#   end
# end

  delete '/blogs/:id/delete' do
    @blog = Blog.find_by_id(params[:id])
    @blog.destroy
    redirect '/blogs'
  end
end




  


