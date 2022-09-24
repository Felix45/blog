class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id].to_i)
  end

  def new
    newpost = Post.new
    respond_to do |format|
      format.html { render :new, locals: { newpost: } }
    end
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.likes_counter = 0
    @post.comments_counter = 0

    respond_to do |format|
      format.html do
        if @post.save
          @post.update_posts_counter
          redirect_to user_post_path(current_user, @post.id)
        else
          newpost = Post.new
          render :new , locals: { newpost: }
        end
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
