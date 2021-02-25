class CommentsController < ApplicationController

# POST /courses/:course_id/comments
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

# PATCH/PUT /courses/:course_id/comments/:id	
def update	
  begin	
    @comment.update(comment_params) 	
  rescue => exception	
    flash[:danger] = exception	
  else	
    flash[:success] = "Updated your comment!"	
  ensure	
    redirect_back fallback_location: "/"	
  end 	
end	

# DELETE /courses/:course_id/comments/:id
def destroy
  begin
    Comment.find(params[:id]).destroy!
  rescue => exception
    flash[:danger] = exception
  else
    flash[:success] = "Removed comment!"
  ensure
    redirect_back fallback_location: "/"
  end
end

 private

 def comment_params
   params.require(:comment).permit(:body, :user_id, :post_id, :course_id)
 end
end