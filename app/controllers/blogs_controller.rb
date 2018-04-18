class BlogsController < ApplicationController
  # GET /todos
  def index
    blogs = Blog.all
    render json: blogs
  end
  def create
    puts '-----'
    puts params[:setting]
    render json: params[:setting]
  end
end
