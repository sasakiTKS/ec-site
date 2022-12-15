class ApplicationController < ActionController::Base

  protected
    # ログイン時のパスを変更してる
    def after_sign_in_path_for(resource)
      if customer_signed_in?
        public_root_path
      else
         admin_path
      end
    end

    #ログアウト時のパスの変更
    def after_sign_out_path_for(resource)
      public_root_path
    end

    # 新規登録の保存機能
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
  			 keys: [:first_name,:last_name,:first_name_kana,:last_name_kana,:postal_code,:address,:telephone_number,:email,])

      #sign_upの際にnameのデータ操作を許。追加したカラム。
  		devise_parameter_sanitizer.permit(:sign_in, keys: [:email])

    end

  private

  # before_action作成

  def set_item
    @item = Item.find(params[:id])
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

end
