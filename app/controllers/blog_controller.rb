require './config/environment'

class BlogController < ApplicationController

 #index action
  get '/blogs' do
    if !user_logged_in?
        redirect to '/login'
    else
      @user = current_user
      @blogs = Blog.all.reverse #=> shows who is the current user
      erb :'/blogs/index'
    end
  end

# NEW
# Make a GET request tp '/blogs/new' - to render the orm
  get '/blogs/new' do
   if user_logged_in?
    @message = session[:message] #=> user logged in with the user id key is equal to the user's id
      erb :'/blogs/new'
   else
    redirect to '/'
  end
end
 
# CREATE
# make a POST request to '/blogs' - Submits the form; That's how we create a new blog
  post '/blogs' do
    @blog = current_user.blogs.create(title: params[:title], location: params[:location], description: params[:description], image_url: params[:image_url], user_id: current_user.id)
   if !@blog.title.empty? 
   redirect to "/blogs/#{@blog.id}" #=> a response to the original post request
  else
   @message = "The title is required. Please try again."
     erb :'/blogs/new'
  end
end

# SHOW
# make a GET request to '/blogs/:id' - This is a dynamic route
  get '/blogs/:id' do
      @message = session[:message]
      @blog = Blog.find_by_id(params[:id])
    if @blog 
        erb :'/blogs/show'
    else
        redirect to '/blogs'
    end
  end

# EDIT
# make a GET request to '/blogs/:id/edit' - Can make changes to the recipe
  get '/blogs/:id/edit' do
         #binding.pry
    @blog = Blog.find_by_id(params[:id])
      erb :'/blogs/edit'
  end

# UPDATE
# Make a PATCH request to '/blog/:id'
  patch '/blogs/:id' do
    if user_logged_in?
      #binding.pry
      @blog = Blog.find_by_id(params[:id])
      params.delete(:_method)
      @blog.update(params)
        redirect to "/blogs/#{@blog.id}"
    else
      @errors = "Please try again"
      erb :'/blogs/login'
    end 
  end 
  
# DESTROY 
# Make a DELETE request to '/blogs/:id'
  delete '/blogs/:id/delete' do
    @blog = Blog.find_by_id(params[:id])
    @blog.destroy
      redirect to '/blogs'
  end
end







  


