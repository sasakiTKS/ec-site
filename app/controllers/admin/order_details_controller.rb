class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(params[:id])
		if @order_detail.update(order_detail_params)
		   flash[:success] = "制作ステータスを変更しました"
		   if @order_detail.making_status == "製作完了"
		   	@order.update(status: "発送準備中")
		   end
		   redirect_to admin_order_path(@order)
		else
		   render "show"
		end
	end

  def order_detail_params
		  params.require(:order_detail).permit(:making_status)
	end

end
