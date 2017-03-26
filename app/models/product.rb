class Product < ApplicationRecord
  belongs_to :supplier
  has_many :images

  has_many :category_products
  has_many :categories, through: :category_products

  has_many :carted_products
  has_many :orders, through: :carted_products
  has_many :users, through: :carted_products

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true
  validates :description, uniqueness: true

  validates :price, numericality: {greater_than: 0, only_integer: true}



  def friendly_created_at
    created_at.strftime("%B %e, %l:%M %p")
  end

  def sale_message
    if price < 10
      return "On Sale!"
    else
      return "Regular price"
    end
  end

  def tax
    return price.to_f * 0.09
  end

  def total
    return price.to_f + tax
  end

  def discounted?
    price.to_f < 10
  end
end
