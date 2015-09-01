class StoreController < ApplicationController
  #helper_method :increment_counter
  skip_before_filter :authorize
  
  def index
    @products = Product.paginate(page: params[:page],per_page: 4)

  	#@products = Product.all
  	increment_counter

  	@cart = current_cart

  end

 def increment_counter
  if session[:counter].nil?
    session[:counter] = 0
  end
  session[:counter] += 1
end



end
