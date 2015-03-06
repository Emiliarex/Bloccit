class FavoritesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    
    
    if favorite.save
      flash[:notice] = "Post was favorited"
      redirect_to [@post.topic, @post]
   else
      flash[:error] = "Something went wrong"
      redirect_to [@post.topic, @post]
   end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find(params[:id])
    authorize @favorite
    
    if favorite.destroy
      flash[:notice] = "Post was unfavorited"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Something went wrong. Post could not be unfavorited"
      redirect_to [@post.topic, @post]
    end
  end
end
