class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order_detail = OrderDetail.find(params[:id])
		if @order_detail.update(order_detail_params)
		   flash[:success] = "制作ステータスを変更しました"
		   redirect_to admin_order_path(@order)
		else
		   render "show"
		end
	end

  def order_detail_params
		  params.require(:order_detail).permit(:maiking_status)
	end

end
