class Public::ItemsController < ApplicationController

  before_action :authenticate_customer!, only: [:show]


	def index
    @genres = Genre.all
    @items = Item.where(is_active: true).page(params[:page]).per(8)
	end

	def show
    @items = Item.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
	end

	private

	def item_params
		parmas.require(:item).permit(:name, :image, :introduction, :genre_id, :price, :is_active)
	end

end