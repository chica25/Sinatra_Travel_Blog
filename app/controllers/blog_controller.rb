require './config/environment'

class BlogController < ApplicationController

  get '/blogs' do
    if !user_logged_in?
        redirect to '/login'
    else
      @user = current_user
      erb :'/blogs/index'
    end
  end

  get '/blogs/new' do
   if user_logged_in?
      erb :'/blogs/new'
   else
    redirect to '/'
  end
end

  post '/blogs' do
     @blog = current_user.blogs.new(title: params[:title], location: params[:location], description: params[:description], image_url: params[:image_url], user_id: current_user.id)
   if @blog.save
      flash[:message] = "Your blog is now posted!"
      #binding.pry
      redirect to "/blogs/#{@blog.id}" 
     
    else
       flash.now[:error] = "Post not created: #{@blog.errors.full_messages.to_sentence}"
        erb :'/blogs/new'
    end
  end

  get '/blogs/:id' do
      @blog = Blog.find_by_id(params[:id])
    if @blog 
        erb :'/blogs/show'
    else
        redirect to '/blogs'
    end
  end

  # get '/blogs/:id/edit' do
  #   @blog = Blog.find_by_id(params[:id])
  #   #binding.pry
  #     erb :'/blogs/edit'
  # end


  # --- Refactor edit method---
  get '/blogs/:id/:edit' do 
    @blog = Blog.find_by_id(params[:id]) #=> is what is passed in from the edit form
      #binding.pry
    if @blog.user_id == current_user.id
      erb :'/blogs/edit'
    else
      redirect to '/users/login'
    end
  end
  
# --  need to protect code
  patch '/blogs/:id' do
    if user_logged_in?
      @blog = Blog.find_by_id(params[:id])
      params.delete(:_method)
      @blog.update(params)
      flash[:message] = "Blog updated successfully!"
        redirect to "/blogs/#{@blog.id}"
    else
      flash[:error] = "Please try again"
      erb :'/users/login'
    end 
  end 
  
  # --- refactor --------
#  patch '/blogs/:id' do
#     if @blog.user_id == current_user.id
#       @blog = Blog.find_by_id(params[:id])
#       params.delete(:_method)
#       @blog.update(params)
#       flash[:message] = "Blog updated successfully!"
#         redirect to "/blogs/#{@blog.id}"
#     else
#       flash[:error] = "Please try again"
#       erb :'/users/login'
#     end 
#   end

  # --  need to protect code
  delete '/blogs/:id/delete' do
    @blog = Blog.find_by_id(params[:id]) 
    @blog.destroy
    flash[:message] = "Blog deleted successfully!"
      redirect to '/blogs'
  end
end
