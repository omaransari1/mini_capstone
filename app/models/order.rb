class Order < ApplicationRecord
  belongs_to :user
  has_many :products, through: :carted_products
  has_many :carted_products

  def update_all_totals
    subtotal = 0
    carted_products.each do |carted_product|
      subtotal += carted_product.subtotal
    end
    tax = subtotal * 0.09
    total = subtotal + tax
    update(subtotal: subtotal, tax: tax, total: total)
  end
  
end
