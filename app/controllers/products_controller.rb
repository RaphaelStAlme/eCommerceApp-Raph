class ProductsController < ApplicationController
    before_action :require_login, except: [:index, :show]
    before_action :set_product, only: [:show, :edit, :update, :destroy]
  
    def index
      @products = Product.all
      @user = current_user
    end
  
    def new
      @product = Product.new
    end
  
    def create
        if current_user_is_seller?
          @product = current_user.seller.products.build(product_params)
          if @product.save
            redirect_to @product, notice: 'Product created successfully.'
          else
            render :new
          end
        else
          redirect_to root_path, alert: "You need to be a seller to create a product."
        end
      end
  
      def show
        @product = Product.find(params[:id])
      end
  
    def edit
    end
  
    def update
      if @product.update(product_params)
        redirect_to @product, notice: 'Product updated successfully.'
      else
        render :edit
      end
    end
  
    def destroy
      if(current_user.email != @product.seller.user.email)
        redirect_to products_url, alert: "You can't delete a product that you didn't create."
      else
        @product.destroy
        flash[:alert] = 'Product deleted successfully.'
        redirect_to products_path

      end
    end
  
    private
  
    def set_product
      @product = Product.find(params[:id])
    end
  
    def product_params
      params.require(:product).permit(:name, :description, :price, :stock)
    end
  end
  