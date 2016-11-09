class ProductsController < ApplicationController
  def products_all_method
    @product_all = Product.all
    render 'products_all.html.erb'
  end
end
