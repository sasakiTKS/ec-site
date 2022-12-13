class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :item
    enum maiking_status: { 製作不可: 0, 製作待ち: 1, 製作中: 3, 製作完了: 4 }
    def sum_order_items
    self.order_details.all.sum(:total_amount)
    end

end
