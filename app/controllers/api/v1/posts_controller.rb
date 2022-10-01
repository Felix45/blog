class Api::V1::PostsController < ApiController
  before_action :authorize_request
    def index
      @user = User.includes(:posts).find(params[:user_id].to_i)
      render json: @user.posts
    end
end
  