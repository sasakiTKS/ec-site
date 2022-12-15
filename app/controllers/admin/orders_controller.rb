class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
  		@orders = Order.current_customer.page(params[:page]).per(10)
  end

  def current_index
    @orders = Order.where(customer_id: params[:id]).page(params[:page]).per(10)
    render :index
  end

  def today_order_index
    now = Time.current
    @orders = Order.where(created_at: now.all_day).page(params[:page]).per(10)
    render :index
  end

	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
		@orders = Order.all
	end

	def update
		@order = Order.find(params[:id])
		@order_details = @order.order_details
		if @order.update(order_params)
		   flash[:success] = "注文ステータスを変更しました"
		   if @order.status == "入金確認"
		     @order_details.each do |order_detail|
		     	order_detail.update(making_status: "製作待ち")
         end
		   end
		   redirect_to admin_order_path(@order)
		else
		   render "show"
		end
	end

	private

	def order_params
		  params.require(:order).permit(:status)
	end

end
