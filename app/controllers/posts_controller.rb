class PostsController < ApplicationController
  
  def index
    @posts =  Post.visible_to(current_user).where("posts.created_at > ?", 7.days.ago).paginate(page: params[:page], per_page: 10)
  end
  
  def create
    @posts = Post.new(post_params)
  
    if @posts.save
      redirect_to @posts, notice: 'File was successfully uploaded!'
    else
      render action: 'new'
    end
end
  
  private
  
  def post_params
    params.require(:friend).permit(:avatar, :name)
  end
end
