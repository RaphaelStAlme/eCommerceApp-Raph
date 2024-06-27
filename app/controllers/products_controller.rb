class ProductsController < ApplicationController
    before_action :require_login, except: [:index, :show]
    before_action :set_product, only: [:show, :edit, :update, :destroy]
  
    def index
      @products = Product.all
    end
  
    def new
      @product = Product.new
    end
  
    def create
        if current_user_is_seller?
          @product = current_user.seller.products.build(product_params)
          if @product.save
            redirect_to @product, notice: 'Produit créé avec succès.'
          else
            render :new
          end
        else
          redirect_to root_path, alert: "Vous devez être un vendeur pour créer des produits."
        end
      end
  
    def show
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
      @product.destroy
      redirect_to products_url, notice: 'Product deleted successfully.'
    end
  
    private
  
    def set_product
      @product = Product.find(params[:id])
    end
  
    def product_params
      params.require(:product).permit(:name, :description, :price, :stock)
    end
  end
  