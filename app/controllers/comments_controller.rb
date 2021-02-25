class CommentsController < ApplicationController
  before_action :this_rating, only: [:update, :destroy]	

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
   params.require(:comment).permit(:body, :user_id, :post_id)
 end

end