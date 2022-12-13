class Public::OrdersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_customer!

  def new
    @order = Order.new
    @cart_items = CartItem.all
    @addresses = current_customer.addresses
    @address = Address.new
  end

   def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)

    if @order.save
      @cart_items.each do |cart_item|
        order_item = OrderDetail.new
        order_item.item_id = cart_item.item_id
        order_item.order_id = @order.id
        order_item.amount = cart_item.amount
        order_item.save
      end
      redirect_to  complete_public_orders_path
      @cart_items.destroy_all
    else
      @order = Order.new(order_params)
      @addresses = current_customer.addresses
      @address = Address.new
      render :new
    end
  end

   def confirm

    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @address = current_customer.addresses.first
    @address = Address.new
    if params[:order][:select] == "1"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
    elsif params[:order][:select] == "2"
      @id =  params[:order][:address_id]
      @order_address = Address.find(@id)
      @order.name = @order_address.name
      @order.address = @order_address.address
      @order.postal_code = @order_address.postal_code
    else
      @order.name = params[:order][:name]
      @order.address = params[:order][:address]
      @order.postal_code = params[:order][:postal_code]
    end

    @sum = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
    @total += @order.shipping_cost.to_i

   end

  def complete
  end

  def index
    @orders = Order.all
    @items = Item.all
    @total = @orders.inject(0) { |sum, item| sum + item.sum_order_items }
  end

	def show
	  @order = Order.find(params[:id])
    @order_details = @order.order_details
	end

  private
  def order_params
    params.require(:order).permit(:name, :address, :postal_code, :total_amount, :payment_method, :shipping_cost, :status)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

  def to_confirm
    redirect_to public_items_path if params[:id] == "confirm"
  end

end