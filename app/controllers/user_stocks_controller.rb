class UserStocksController < ApplicationController
  before_action :authorize!

  def new
  end

  def create
  end

  def index
    @purchased_user_stocks = UserStock.where(user_id: current_user.id, purchased: true)
  end

  def show
  end

  def edit
    @stock = Stock.find_by(id: params[:id])
    @user_stock = UserStock.find_by(id: params[:id])
  end

  def update
    user_stock = UserStock.find_by(id: params[:id])
    user_stock.purchase_price = params[:user_stock][:purchase_price]
    user_stock.quantity = params[:user_stock][:quantity]
    user_stock.purchased = true
    user_stock.save!

    flash[:success] = "Stock purchase successfully created!"
    redirect_to user_stocks_path
  end

  def destroy
  end


  private

  def user_stock_params
  end
end
