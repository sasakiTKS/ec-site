class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def show
  	@order_details = OrderDetail.all
  	@orders = Order.all
  end

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
		if @order_detail.update(order_detail_params)
		   flash[:success] = "制作ステータスを変更しました"
		   if @order_detail.making_status == "製作中"
		   	@order.update(status: "製作中")
		   end
		   if @order_details.count == @order_details.where(making_status: 3).count
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
