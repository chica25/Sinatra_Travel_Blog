class BlogController < ApplicationController

    get '/blogs/new' do
        erb :'blog/new'
    end

    get '/blogs' do
        @blogs = Blog.all
        erb :'blog/index'
    end

    post '/blogs' do
        blog = Blog.new(params)
        blog.save
        # Create an if and else statement after creating validation
        redirect '/blogs'
    end

    #create a show route that displays info about the blog
    #get request
    get '/blogs/:id' do
        @blogs = Blog.find_by_id(params[:id])
        erb :'blog/show'
    end

  end