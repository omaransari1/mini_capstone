class CartedProduct < ApplicationRecord
  belongs_to :users
  belongs_to :products
  belongs_to :orders
end
