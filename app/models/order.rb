class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

   #注文の全ての数量合計
  def sum_order_items
    self.order_details.all.sum(:amount)
  end

  #注文の合計金額
  # def total_price
  #   array = []
  #   self.order_details.each do |order_detail|
  #     array << order_detail.tax_price * order_details.amount
  # end
  #   array.sum
  # end

  enum payment_method: {"クレジットカード": 0,"銀行振込": 1}
	enum order_status: {"入金待ち": 0,"入金確認": 1,"製作中": 2,"発送準備中": 3, "発送済み": 4}

end
