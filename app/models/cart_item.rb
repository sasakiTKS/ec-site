class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  has_one_attached :image
  def sum_of_price
    item.taxin_price * amount
  end
  def sum_price
    item.tax_price * amount
  end
  def sub_price(sub)
    (taxf_price(sub.item.tax_out_price) * sub.amount)
  end
end
