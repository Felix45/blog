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

  def show
    @post = Post.find(params[:id])
  end
end
