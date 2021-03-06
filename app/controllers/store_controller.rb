class StoreController < ApplicationController
  #helper_method :increment_counter
  skip_before_filter :authorize
  
  def index
 
 
 if params[:type_of_wine]
@products = Product.paginate(page: params[:page],per_page: 4).where("type_of_wine LIKE ? ", "%#{params[:type_of_wine]}%")
     elsif params[:search]
@products = Product.paginate(page: params[:page],per_page: 4).search(params[:search]).order("created_at DESC")
 
    elsif params[:price] && params[:price] == '1'
 @products = Product.paginate(page: params[:page],per_page: 4).where(price: 100..200)

    elsif params[:price] && params[:price] == '2'
 @products = Product.paginate(page: params[:page],per_page: 4).where(price: 200..300)

    elsif params[:price] && params[:price] == '3'
 @products = Product.paginate(page: params[:page],per_page: 4).where(price: 300..500)
    else
     
      @products = Product.paginate(page: params[:page],per_page: 4)

    end
  	#@products = Product.all
  	increment_counter
  	@cart = current_cart
  end

def show
@cart = current_cart
@product = Product.find(params[:product_id])
end


 def increment_counter
  if session[:counter].nil?
    session[:counter] = 0
  end
  session[:counter] += 1
end



end
