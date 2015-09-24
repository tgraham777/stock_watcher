class StocksController < ApplicationController
  before_action :authorize!
  
  def index
  end

  def show
  end

  def new
    @stock = 'stock'
  end
end
