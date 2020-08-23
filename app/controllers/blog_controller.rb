require './config/environment'

class BlogController < ApplicationController

  get '/blogs' do
    if !user_logged_in?
        redirect '/login'
    else
    @blogs = Blog.all
      @user = current_user
      erb :'/blogs/index'
    end
  end

  get '/blogs/new' do
   if user_logged_in?
    erb :'/blogs/new'
   else
    redirect '/'
  end
end

  post '/blogs' do
    @blog = current_user.blogs.new(title: params[:title], location: params[:location], description: params[:description], image_url: params[:image_url], user_id: current_user.id)
    if @blog.save
      flash[:message] = "Your blog is now posted!"
      redirect "/blogs/#{@blog.id}" 
    else
       flash.now[:error] = "Post not created: #{@blog.errors.full_messages.to_sentence}"
        erb :'/blogs/new'
    end
  end

  get '/blogs/:id' do
    @blog = Blog.find_by_id(params[:id])
    @user = current_user
    if @blog 
        erb :'/blogs/show'
    else
        redirect '/blogs'
    end
  end


  get '/blogs/:id/edit' do 
    @blog = Blog.find_by_id(params[:id]) #=> is what is passed in from the edit form
    if @blog.user_id == current_user.id
      erb :'/blogs/edit'
    else
      flash[:error] = "You don't have permission"
      redirect '/login'
    end
  end

  #--- refactor --------
 patch '/blogs/:id' do
  @blog = Blog.find_by_id(params[:id])
    if @blog.user_id == current_user.id
      params.delete(:_method)
      @blog.update(params)
        flash[:message] = "Blog updated successfully!"
        redirect "/blogs/#{@blog.id}"
    else
      erb :'/users/login'
    end 
  end
  
  delete '/blogs/:id/delete' do 
   @blog = Blog.find_by_id(params[:id])
   if @blog.user_id == current_user.id
      @blog.destroy
        flash[:message] = "Blog deleted successfully!"
        redirect '/blogs'
    else
      flash[:error] = "You don't have permission"
        erb :'/login'
      end
    end
 end

