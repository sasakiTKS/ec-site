class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :item

    def sum_order_items
    self.order_details.all.sum(:total_amount)
    end

    enum making_status: { "製作不可": 0, "製作待ち": 1, "製作中": 2, "製作完了": 3 }

end
