class CommentsController < ApplicationController
  def new
   
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:notice] = "Comment successfully created"
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment exploded"
      redirect_to [@topic, @post]
    end
      
  end
  
  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed"
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      redirect_to [@topic, @post]
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end
end
