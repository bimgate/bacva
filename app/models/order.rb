class Order < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy


	PAYMENT_TYPES = [ "Gotovinsko placanje" , "Virmansko" , "Online placanje" ]



def add_line_items_from_cart(cart)
	cart.line_items.each do |item|
		item.cart_id = nil
		line_items << item
	end
end

def total_price
		line_items.to_a.sum { |item| item.total_price }
end





	validates :name, :address, :email, :pay_type, :presence => true
	validates :pay_type, :inclusion => PAYMENT_TYPES
end
