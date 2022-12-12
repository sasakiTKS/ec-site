class Public::CustomersController < ApplicationController


  def withdrawal
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to public_root_path
  end

  def show
    @customer = Customer.find(params[:id])
	end

	def edit
    @customer = Customer.find(params[:id])
	end

	def update
    @customer = Customer.find(params[:id])
		if @customer.update(customer_params)
       flash[:success] = "登録情報を変更しました"
       redirect_to public_customer_path
    else
       render :edit and return
    end
	end

  def unsubscribe
  end

	private

	def customer_params
  	params.require(:customer).permit(:first_name,:last_name,:first_name_kana,:last_name_kana,:postal_code,:address,:telephone_number,:email,:is_deleted)
  end

end
