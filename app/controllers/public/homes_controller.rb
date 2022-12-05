class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    @genres = Genre.all
    @random = Item.order("RANDOM()").limit(4)
  end

  def about
  end
end
