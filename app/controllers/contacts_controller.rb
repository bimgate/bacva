class ContactsController < ApplicationController
  skip_before_filter :authorize

  def new
    @cart = current_cart
    @contact = Contact.new
  end

  def create
    @cart = current_cart
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Hvala vam na poruci, uskoro cemo vas kontaktirati!'
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end
end