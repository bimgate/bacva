class OrdersController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]
  #include CurrentCart
  #before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @cart = current_cart
    #@orders = Order.all

   # @orders = Order.paginate :page=>params[:page], :order=>'created_at desc' ,
    #:per_page => 2

    @orders = Order.paginate(page: params[:page],per_page: 3)

    respond_to do |format|
    format.html # index.html.erb
    format.xml { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @cart = current_cart
  end

  # GET /orders/new
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Vasa porudzbina je prazna"
      return
    end  

    @order = Order.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @cart = current_cart
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(current_cart)
    

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to store_url, notice: 'Uspesno ste porucili nase proizvode.' }
       
        format.json { render :show, status: :created, location: @order }
      else

        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def current_cart
    Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
