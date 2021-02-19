class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :this_course, only: [:show, :edit, :update, :destroy]
  
  # get /courses
  def index
    @courses = Course.joins("INNER JOIN users ON courses.user_id = users.id").select("users.username, courses.*")
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
    # if subscribed, gets that subscription, else creates new subscription (so that can render @subscription )
  end

  # get courses/:id/edit 
  def edit
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
    else
      flash[:success] = "Deleted the course!"
    ensure
      redirect_back fallback_location: "/"
    end
  end

  private

  def this_course
    @course = Course.find(params[:id])
  end

  def course_params
    course_params = params.require(:course).permit(:user_id, :title)
    course_params[:user_id] ||= session[:user_id]
    return course_params
  end

end
