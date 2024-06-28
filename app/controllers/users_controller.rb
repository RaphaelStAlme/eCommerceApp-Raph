class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :update_seller_status]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      if params[:user][:become_seller] == '1'
        @user.create_seller
      end
      redirect_to root_path, notice: 'Account created successfully.'
    else
      render :new
    end
  end

  def update_seller_status
    @user = current_user
    if params[:seller] == '1'
      @user.create_seller unless @user.seller.present?
      flash[:notice] = "You are now a seller."
    else
      @user.seller.destroy if @user.seller.present?
      flash[:notice] = "You are no longer a seller."
    end
    redirect_to profile_path
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def authenticate_user
    render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user
  end
end
