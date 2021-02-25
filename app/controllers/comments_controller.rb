class CommentsController < ApplicationController
  before_action :this_comment, only: [:update, :destroy]	

# POST /comments
def create
  begin
    Comment.create!(comment_params)
  rescue => exception
    flash[:danger] = exception
  else
    flash[:success] = "Added comment!"
  ensure
    redirect_back fallback_location: "/"
  end
end

# PATCH/PUT /comments/:id	
def update	
  begin	
    @comment.update!(comment_params) 	
  rescue => exception	
    flash[:danger] = exception	
  else	
    flash[:success] = "Updated your comment!"	
  ensure	
    redirect_back fallback_location: "/"	
  end 	
end	

# DELETE /comments/:id
# DELETE /comments/:id	

def destroy
  begin
    @comment.destroy!
  rescue => exception
    flash[:danger] = exception
  else
    flash[:success] = "Removed comment!"
  ensure
    redirect_back fallback_location: "/"
  end
end

 private

  def this_comment	
    @comment = Comment.find(params[:id])	
  end	

 def comment_params
  comment_params = params.require(:comment).permit(:post_id, :user_id, :body)	
  comment_params[:post_id] ||= params[:post_id]	
  comment_params[:user_id] ||= session[:user_id]	
  return comment_params	
 end
  
end