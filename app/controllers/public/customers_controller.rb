class Public::CustomersController < ApplicationController
  
  def show
    @customer = Customer.find(params[:id])
	end

	def quit
	end

	def out
    @customer = current_customer
    @customer.update(is_valid: true)

    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
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

  def contact
  end

	private

	def customer_params
  	params.require(:customer).permit(:first_name,:last_name,:first_name_kana,:last_name_kana,:postal_code,:address,:telephone_number,:email,:is_deleted)
  end

end
