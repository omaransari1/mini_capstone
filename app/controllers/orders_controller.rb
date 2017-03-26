class OrdersController < ApplicationController
  before_action :authenticate_user!
  def create
    product = Product.find_by(id: params[:id])
    calculated_subtotal = product.price * params[:quantity].to_i
    calculated_tax = calculated_subtotal * 0.09
    calculated_total = calculated_subtotal + calculated_tax

    @order = Order.new(
      user_id: current_user.id,
      quantity: params[:quantity],
      product_id: params[:product_id],
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculated_total
      )
    @order.save
    flash[:success] = "Your order was successful"
    redirect_to "/orders/#{@order.id}" 

    @carted_products = current_user.carted_products.where(status: "carted")
    subtotal = 0
    @carted_products.each do |carted_product|
      subtotal += carted_product.quantity * carted_product.product.price
    end
    tax = subtotal * 0.09
    total = subtotal + tax

    order = Order.new(
      user_id: current_user.id,
      subtotal: subtotal,
      tax: tax,
      total: total)
    order.save
    carted_products.update_all(status: "purchased", order_id: order.id)
  end

  def show
    @order = Order.find_by(id: params[:id])
    render 'show.html.erb'
  end
end
