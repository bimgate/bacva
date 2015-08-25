class AdminController < ApplicationController
  #include CurrentCart
  def index
  	@cart = current_cart  	
  	@total_orders = Order.count
  end
end
