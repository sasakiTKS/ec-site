class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  belongs_to :genre
  has_one_attached :image
  def taxin_price
        (price*1.1).round
  end
  def tax_price
        (price*1.0).round
  end
  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
end
