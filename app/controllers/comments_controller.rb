class CommentsController < ApplicationController
  def new
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment successfully created"
    else
      flash[:error] = "Comment exploded"
    end
      redirect_to [@topic, @post]
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end
end
