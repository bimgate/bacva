class Notifier < ApplicationMailer

  
  default :from => 'Bacva <bacvashop@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)

@order = order

     mail :to => order.email, :subject => 'Bacva: Potvrda porudzbine'
    
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    

    @order = order
   mail :to => order.email, :subject => 'Bacva: Potvrda posiljke'
  end
end
