class Product < ActiveRecord::Base

	default_scope { order(created_at: :desc) }
	has_many :line_items
	has_many :orders, :through => :line_items

	validates :title, :description, :image_url, :presence => true
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01} 
	validates :title, :uniqueness => true
	validates :image_url, :format => {

		:with => %r{\.(gif|jpg|png)\z}i,
        :message => 'must be a URL for GIF, JPG or PNG image.'
	}

before_destroy :ensure_not_referenced_by_any_line_item

def ensure_not_referenced_by_any_line_item

	if line_items.count.zero?
		return true
	else
		errors.add(:base, 'Line Items present')
	return false
	
	end
	end

	# It returns the articles whose titles contain one or more words that form the query
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("title like ?", "%#{query}%") 
  end
  

end