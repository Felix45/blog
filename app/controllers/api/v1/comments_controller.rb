class Api::V1::CommentsController < ApiController
  before_action :authorize_request, only: [:create]
  def index
    @user = User.includes(posts: [:comments]).find(params[:user_id])
    @post = @user.posts.find_by(id: params[:post_id])
    render json: @post ? @post.comments : "No comment found for post: #{params[:post_id]}"
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.post_id = @post.id
    render json: @comment if @comment.save
  end

  def comment_params
    params.require(:comment).permit(:text, :post_id, :author_id)
  end
end
