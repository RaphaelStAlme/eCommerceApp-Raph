class ApplicationController < ActionController::Base
    before_action :authenticate_user
    helper_method :current_user, :logged_in?
  
    private
  
    # Renvoie l'utilisateur actuellement connecté (s'il y en a un)
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  
    # Vérifie si l'utilisateur est connecté
    def logged_in?
      current_user.present?
    end
  
    # Redirige vers la page de connexion si l'utilisateur n'est pas connecté
    def require_login
      unless logged_in?
        flash[:alert] = "Vous devez être connecté pour accéder à cette page."
        redirect_to login_path
      end
    end

    def current_user_is_seller?
        current_user&.seller.present?
      end
    
    def require_seller
        unless current_user_is_seller?
          flash[:alert] = "Vous devez être un vendeur pour accéder à cette page."
          redirect_to root_path
        end
    end

   
  end