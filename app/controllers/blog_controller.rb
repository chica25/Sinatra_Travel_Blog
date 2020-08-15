require './config/environment'

class BlogController < ApplicationController


  # before do 
  #   user_logged_in
  # end

  #-- my code----
 #index action
  get '/blogs' do
    if !user_logged_in
        redirect '/login'
    else
      @user = current_user
      @blogs = Blog.all.reverse #=> shows who is the current user
      erb :'/blogs/index'
    end
  end

# NEW
# Make a GET request tp '/blogs/new' - to render the orm
  get '/blogs/new' do
    @message = session[:message]
      erb :'/blogs/new'
  end

 
# CREATE
# make a POST request to '/blogs' - Submits the form; That's how we create a new blog
  post '/blogs' do
    @blog = current_user.blogs.create(title: params[:title], location: params[:location], description: params[:description], image_url: params[:image_url])
   #if !@blog.title.empty? 
   redirect "/blogs/#{@blog.id}" #=> a response to the original post request
  # else
  # @message = "The title is required. Please try again."
     erb :'/blogs/new'
  end
#end

  # post '/blogs' do
  #   @blog = Blog.new(title: params[:title])
  # if !@blog.title.empty? 
  #   @blog.save
  #   redirect "/blogs/#{@blog.id}"
  # else
  #   @message = "The title is required. Please try again."
  #   erb :'/blogs/new'
  #   end
  # end


# SHOW
# make a GET request to '/blogs/:id' - This is a dynamic route
  get '/blogs/:id' do
      @message = session[:message]
      @blog = Blog.find_by_id(params[:id])
    if @blog 
        erb :'/blogs/show'
    else
        redirect '/blogs'
    end
  end


# UPDATE 
# Edit
# make a GET request to '/blogs/:id/edit' - Can make changes to the recipe
  get '/blogs/:id/edit' do
        # binding.pry
    @blog = Blog.find_by_id(params[:id])
      erb :'/blogs/edit'
  end


# Update
# Make a PATCH request to '/blog/:id'

  # patch '/blogs/:id' do
  #   @blog = Blog.find_by_id(params[:id])
  #   params.delete(:_method)
  #   @blog.update(params)
  #     redirect "/blogs/#{@blog.id}"
   
  # end 

  patch '/' do
    
  end

# DESTROY 
# Make a DELETE request to '/blogs/:id'
  delete '/blogs/:id/delete' do
    @blog = Blog.find_by_id(params[:id])
    @blog.destroy
      redirect '/blogs'
  end
end


# --- end of code----




# READ








  


