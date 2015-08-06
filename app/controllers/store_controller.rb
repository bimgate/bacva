class StoreController < ApplicationController
  #helper_method :increment_counter

  def index
  	@products = Product.all
  	increment_counter
  end

 def increment_counter
  if session[:counter].nil?
    session[:counter] = 0
  end
  session[:counter] += 1
end



end
