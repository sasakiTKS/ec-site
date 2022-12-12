class Public::OrdersController < ApplicationController
  include ApplicationHelper

  before_action :to_confirm, only: [:show]
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @cart_items = CartItem.all
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new
     if params[:order][:address] == "address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.destination = current_customer.last_name + current_customer.first_name
     elsif params[:order][:addresses] == "registration"
      delivery = DeliverDestination.find(params[:order][:deliver_destination_id])
      @order.postcode = delivery.postcode
      @order.address = delivery.address
      @order.destination = delivery.destination
     elsif params[:order][:addresses] == "new_address"
      @order.postcode = params[:order][:postcode]
      @order.address = params[:order][:address]
      @order.destination = params[:order][:destination]
      @delivery = "1"
     end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    flash[:notice] = "ご注文が確定しました。"
    redirect_to complete_public_orders_path

    if params[:order][:delivery] == "1"
      current_customer.deliver_destinations.create(address_params)
    end

    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
    OrderDetail.create(
      item: cart_item.item,
      order: @order,
      amount: cart_item.amount,
      # tax_price: tax_price(cart_item.item.price)
      )
    end

     @cart_items.destroy_all
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @item_orders = @order.item_orders
  end

  private
  def order_params
    params.require(:order).permit(:name, :address, :postal_code, :total_amount, :payment_method, :shipping_cost, :status)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

  def to_confirm
    redirect_to customer_items_path if params[:id] == "confirm"
  end

end