class Admin::GenresController < ApplicationController
 before_action :authenticate_admin!, except: [:show, :index]

  def index
    @genre = Genre.new
    @genres = Genre.all.page(params[:page]).per(10)
    # perでindexで表示する列数を決める
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
       flash[:notice] = "ジャンルを追加しました"
       redirect_to admin_genres_path
    else
      @genres = Genre.all.page(params[:page]).per(10)
      render :index and return
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルを変更しました"
      redirect_to admin_genres_path
    else
       render :edit and return
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
