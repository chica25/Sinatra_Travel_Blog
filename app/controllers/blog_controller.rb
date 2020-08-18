require './config/environment'

class BlogController < ApplicationController

 #index action 
  get '/blogs' do
    if !user_logged_in?
        redirect to '/login'
    else
      @user = current_user
      erb :'/blogs/index'
    end
  end

# NEW
# Make a GET request tp '/blogs/new' - to render the form
  get '/blogs/new' do
   if user_logged_in?
      erb :'/blogs/new'
   else
    redirect to '/'
  end
end

# CREATE
  post '/blogs' do
     @blog = current_user.blogs.new(title: params[:title], location: params[:location], description: params[:description], image_url: params[:image_url], user_id: current_user.id)
   if @blog.save
      flash[:message] = "Your blog is now posted!"
      redirect to "/blogs/#{@blog.id}" 
    else
       flash.now[:error] = "Post not created: #{@blog.errors.full_messages.to_sentence}"
        erb :'/blogs/new'
    end
  end

# SHOW
# make a GET request to '/blogs/:id' - This is a dynamic route
  get '/blogs/:id' do
      @blog = Blog.find_by_id(params[:id])
    if @blog 
        erb :'/blogs/show'
    else
        redirect to '/blogs'
    end
  end

# EDIT
# make a GET request to '/blogs/:id/edit' - Can make changes to a blog
  get '/blogs/:id/edit' do
    @blog = Blog.find_by_id(params[:id])
      erb :'/blogs/edit'
  end

# UPDATE
# Make a PATCH request to '/blog/:id'
  patch '/blogs/:id' do
    if user_logged_in?
      @blog = Blog.find_by_id(params[:id])
      params.delete(:_method)
      @blog.update(params)
      flash[:message] = "Blog updated successfully!"
        redirect to "/blogs/#{@blog.id}"
    else
      flash[:error] = "Please try again"
      erb :'/blogs/login'
    end 
  end 
  
# DESTROY 
# Make a DELETE request to '/blogs/:id'
  delete '/blogs/:id/delete' do
    @blog = Blog.find_by_id(params[:id])
    @blog.destroy
    flash[:message] = "Blog deleted successfully!"
    redirect to '/blogs'
  end
end







  


