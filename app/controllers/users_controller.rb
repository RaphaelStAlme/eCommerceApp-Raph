class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :upgrade_to_seller]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # Save the user
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully.'
    else
      render :new
    end
  end

  def upgrade_to_seller
    if current_user.seller.nil?
      current_user.create_seller
      redirect_to root_path, notice: "Vous êtes maintenant un vendeur."
    else
      redirect_to root_path, alert: "Vous êtes déjà un vendeur."
    end
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
