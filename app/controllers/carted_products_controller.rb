class CartedProductsController < ApplicationController
  before_action :authenticate_user
  def create
    carted = CartedProduct.new(
      user_id: current_user.id, 
      product_id: params[:product_id],
      quantity: params[:quantity],
      status: "carted"
      )
    carted.save
    redirect_to '/checkout'
  end

  def index
    @carted_products = current_user.carted_products.where(status: "carted")
    if @carted_products.length > 0
      render '/index.html.erb'
    else 
      redirect_to 
  end

  def destroy
    carted_product = CartedProduct.find_by(id: params[:id])
    carted_product.status = "removed"
    carted_product.save
    flash[:success] = "product removed"
    redirect_to "/carted_products"
  end
end
