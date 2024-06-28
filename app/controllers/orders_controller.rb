class OrdersController < ApplicationController
    before_action :require_login, :require_buyer, :not_seller_product 
  
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
      flash[:notice] = "Your order has been placed successfully."
      redirect_to @product
    else
      flash[:alert] = "Your order could not be processed. Please try again."
      render :new
    end
  end
  
    private
  
    def order_params
      params.require(:order).permit(:quantity)
    end
  
    def require_buyer
      unless current_user.buyer
        flash[:alert] = "You need to be a buyer to access this page."
        redirect_to products_path
      end
    end

    def not_seller_product
      @product = Product.find(params[:product_id])
      if current_user.seller == @product.seller
        flash[:alert] = "You can't buy your own product."
        redirect_to products_path
      end
    end
  end
  