class OrdersController < ApplicationController
    before_action :require_login, :require_buyer
  
  def new
    @product = Product.find(params[:product_id])
    @order = Order.new
  end

  def create
    @product = Product.find(params[:product_id])
    @order = current_user.buyer.orders.new(order_params)
    @order.product = @product
    @order.total_price = @product.price * @order.quantity

    if @order.save
      @product.update(stock: @product.stock - @order.quantity)
      flash[:notice] = "Commande passée avec succès."
      redirect_to @product
    else
      flash[:alert] = "Échec de la commande. Veuillez réessayer."
      render :new
    end
  end
  
    private
  
    def order_params
      params.require(:order).permit(:quantity)
    end
  
    def require_buyer
      unless current_user.buyer
        flash[:alert] = "Vous devez être un acheteur pour passer une commande."
        redirect_to products_path
      end
    end
  end
  