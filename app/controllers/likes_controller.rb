class LikesController < ApplicationController
  def new; end

  def create
    @post = Post.find(params[:post_id])
    @user_id = current_user.id
    @like = Like.new(post_id: @post.id, author_id: @user_id)
    @like.author = current_user
    @like.post = Post.find(@post.id)
    @like.save
    redirect_to user_post_path(current_user, @post.id)
  end
end
