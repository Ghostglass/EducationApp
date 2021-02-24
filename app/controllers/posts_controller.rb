class PostsController < ApplicationController
  before_action :this_post, only: [:show, :edit, :update, :destroy]
  before_action :this_course, :is_owner, :is_subscribed
  before_action :only_permit_owner, only: [:edit, :update, :destroy, :edit_all, :sort]
  
  # get /courses/:id/posts
  def index
    @posts = Post.with_rich_text_content.where(course_id: params[:course_id]).order(:position)
  end
  
  # get /courses/:id/posts/new
  def new
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
    redirect_to course_post_url(@course, @post)
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

  # get /courses/:course_id/posts/edit
  def edit_all
    @posts = Post.with_rich_text_content.where(course_id: params[:course_id]).order(:position)
  end

  # patch /courses/:course_id/posts
  def sort
    params[:post].each_with_index do |id, index|
      Post.where(id: id).update_all(position: index + 1)
      # user where so only one db request
    end
    head :ok
  end

  private

  def this_post
    @post = Post.with_rich_text_content_and_embeds.find(params[:id])
  end
  
  def this_course
    @course = Course.find_by_sql("    	
    SELECT
      courses.*,
      (SELECT id FROM subscriptions WHERE subscriptions.course_id = courses.id #{ session[:user_id].nil? ? "" : "AND subscriptions.user_id = #{ session[:user_id] }" }) as is_subbed
    FROM courses
    WHERE courses.id = #{ params[:course_id] }
    GROUP BY courses.id;
    ").first
  end

  def is_subscribed
    unless @course.is_subbed || @is_owner
      flash[:warning] = "You need to be subscribed to view this content"
      redirect_to course_url(@course)
    end
  end

  def post_params
    post_params = params.require(:post).permit(:course_id, :title, :content)
    post_params[:course_id] ||= params[:course_id]
    return post_params
  end
end
