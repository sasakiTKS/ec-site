class Public::CartItemsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @items = Item.all
    @genres = Genre.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: params[:cart_item][:amount].to_i)
    flash[:notice] = "#{@cart_item.item.name}の数量を変更しました。"
    redirect_to public_cart_items_path
  end

  def create
    @cart_item = current_customer.cart_items.new(params_cart_item)
    @update_cart_item = CartItem.find_by(item: @cart_item.item)
    if @update_cart_item.present? && @cart_item.valid?
      @cart_item.amount += @update_cart_item.amount.to_i
      @update_cart_item.destroy
    end
    if @cart_item.save
      flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
      redirect_to public_cart_items_path
    else
      @item = Item.find(params[:cart_item][:item_id])
      @cart_item = CartItem.new
      flash[:alert] = "個数を選択してください。"
      render "customer/items/show"
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:alert] = "#{@cart_item.item.name}を削除しました。"
    redirect_to public_cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    flash[:alert] = "カートの商品を全て削除しました。"
    redirect_to public_cart_items_path
  end

  private

  def params_cart_item
    params.require(:cart_item).permit(:amount, :item_id, :image)
  end

  def customer
    unless CartItem.find(params[:id]).customer.id.to_i == current_customer.id
      redirect_to customer_customer_path
    end
  end

end