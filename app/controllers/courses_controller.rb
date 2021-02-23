class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :this_course, only: [:show, :edit, :update, :destroy]

  # get /courses
  def index
    @courses = Course.with_attached_main_image.find_by_sql("
      SELECT	
        users.username,	
        courses.*	
      FROM (	
        SELECT	
          AVG(coalesce(ratings.value, 0)) AS rating,	
          courses.*	
        FROM	
          courses	
        FULL JOIN ratings ON courses.id = ratings.course_id	
      GROUP BY	
        courses.id) AS courses	
        JOIN users ON users.id = courses.user_id;")
  end

  # get /courses/new
  def new
    @course = Course.new
  end

  #post /courses
  def create
    begin
      course = Course.create!(course_params)
    rescue => exception
      flash[:danger] = exception
      redirect_back fallback_location: "/"
    else
      flash[:success] = "Created a new course!"
      redirect_to course_url(course)
    end
  end

  # get /courses/:id
  def show
    @subscription = Subscription.find_by(course_id: params[:id], user_id: session[:user_id]) || Subscription.new()
    @user_rating = Rating.find_by(user_id: session[:user_id], course_id: params[:id]) || Rating.new
    @posts = @course.posts.with_rich_text_content
    # if subscribed, gets that subscription, else creates new subscription (so that can render @subscription )
  end

  # put/patch courses/:id
  def update
    begin
      @course.update!(course_params)
    rescue => exception
      flash[:danger] = exception
      redirect_back fallback_location: "/"
    else
      flash[:success] = "Edited the course!"
      redirect_to course_url(@course)
    end
  end

  # delete courses/:id
  def destroy
    begin
      @course.destroy!
    rescue => exception
      flash[:danger] = exception
      redirect_back fallback_location: "/"
    else
      flash[:success] = "Deleted the course!"
      redirect_to courses_url
    end
  end

  private

  def this_course
    @course = Course.with_attached_main_image.find_by_sql("
    SELECT	
      users.username,	
      courses.*	
    FROM (	
      SELECT	
        AVG(coalesce(ratings.value, 0)) AS rating,	
        courses.*	
      FROM	
        courses	
      FULL JOIN ratings ON courses.id = ratings.course_id	
    GROUP BY	
      courses.id) AS courses	
      JOIN users ON users.id = courses.user_id
    WHERE
      courses.id = #{params[:id]};").first
  end

  def course_params
    course_params = params.require(:course).permit(:user_id, :title, :description, :rating, :main_image)
    course_params[:user_id] ||= session[:user_id]
    # for adding a new course
    return course_params
  end

end
