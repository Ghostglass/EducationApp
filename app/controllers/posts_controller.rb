class PostsController < ApplicationController
  before_action :this_post, only: [:show, :edit, :update, :destroy]
  
  # get /courses/:id/posts
  def index
    @posts = Post.where(course_id: params[:course_id]).order(:position)
  end
  
  # get /courses/:id/posts/new
  def new
    @course = Course.find(params[:course_id])
    @post = Post.new
  end

  # post /courses/:course_id/posts
  def create
    begin
      Post.create!(post_params)
    rescue => exception
      flash[:danger] = exception
    else
      flash[:success] = "Created a new post!"
    ensure
      redirect_to action: "index"
    end
  end

  # get /courses/:course_id/posts/:id
  def show
  end

  # get courses/:course_id/posts/:id/edit 
  def edit
  end

  # patch/put courses/:course_id/posts/:id 
  def update
    begin
      @post.update!(post_params)
    rescue => exception
      flash[:danger] = exception
      redirect_back fallback_location: "/"
    else
    flash[:success] = "Edited the post!"
    redirect_to course_post_url(@post)
    end
  end

  # delete courses/:course_id/posts/:id
  def destroy
    begin
      @post.destroy!
    rescue => exception
      flash[:danger] = exception
      redirect_back fallback_location: "/"
    else 
      flash[:success] = "Deleted the post!"
      redirect_to action: "index"
    end
  end

  private

  def this_post
    @post = Post.find(params[:id])
    @course = @post.course
  end

  def post_params
    post_params = params.require(:post).permit(:course_id, :content)
    post_params[:course_id] ||= params[:course_id]
    return post_params
  end
end
