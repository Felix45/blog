class Api::V1::UsersController < ApiController
  before_action :authorize_request, only: [:index, :show]
  #before_action :find_user, except: %i[create index]
  
    def index
      @users = User.all
      render :json => @users, only: [:id, :name, :photo, :bio, :email]
    end

    def create
      @user = User.new(configure_permitted_parameters)
      if @user.save
       render :json => @user, only: [:id, :name, :photo, :bio, :email]
      else
       render json: { errors: @user.errors.full_messages}
      end
    end
  
    def show
      @user = User.find(params[:id].to_i)
      render :json => @user, only: [:id, :name, :photo, :bio, :email]
    end

    def configure_permitted_parameters
      params.permit(:name, :bio, :email, :password, :password_confirmation)
    end
  end
  