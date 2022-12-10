class Item < ApplicationRecord
  has_many :cart_items
  belongs_to :genre

  has_one_attached :image

end
