class CommentsController < ApplicationController
  def new
    newcomment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { newcomment: } }
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(post_id: @post.id, author_id: current_user.id, text: comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to user_post_path(current_user, @post.id)
    else
      newcomment = Comment.new
      flash.now[:error] = 'Error: comment could not be saved'
      render :new, locals: { newcomment: }
    end
  end

   def destroy
    post = Post.find(params[:post_id])
    Comment.destroy(params[:id])
    post.comments_counter -= 1
    post.save
    redirect_to user_posts_path(current_user.id)
  end

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end
