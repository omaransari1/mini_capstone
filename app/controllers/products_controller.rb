class ProductsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show, :search]
  def index
    only_show_discount = params[:discount] == "true"
    if only_show_discount
      @products = Product.where("price < ?", 10)
    elsif params[:category_name] != nil
      selected_category = Category.find_by(name: params[:category_name])
      @products = selected_category.products
    else
      sort_attribute = params[:sort] || "name"
      sort_order = params[:sort_order] || "asc"
      @products = Product.order(sort_attribute => sort_order)
    end
    # @product_all = Product.all
    render 'index.html.erb'
  end
  def show
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    render 'show.html.erb'
  end
  def new
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    render 'new.html.erb'
  end
  def create
    product = Product.new(
      name: params["name"],
      price: params["price"],
      image: params["image"],
      description: params["description"]
      )
    product.save
    
    flash[:success] = "Product Created"
    redirect_to "/products/#{@product.id}"
  end

  def edit
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    render 'edit.html.erb'
  end

  def update
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    @product.name = params[:name]
    @product.price = params[:price]
    @product.image = params[:image]
    @product.description = params[:description]
    if @product.save
      render 'update.html.erb'
    else 
      render 'edit.html.erb'
    end
  end

  def destroy
    product_id = params[:id]
    product = Product.find_by(id: product_id)
    product.destroy
    render 'destroy.html.erb'
  end
end
