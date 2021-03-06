class LineItemsController < ApplicationController
skip_before_filter :authorize, :only => [:create, :update]  
  # GET /line_items
  # GET /line_items.xml
  def index
    @cart = current_cart

    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.xml
  def show
    @cart = current_cart

    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.xml
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @cart = current_cart
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.xml
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    #order = Order.find(order_params)
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save        
        format.html { redirect_to(store_url) } 
             
        format.js   { @current_item = @line_item }
        #format.json { render action: 'show', status: :created, location: @line_item }
        
        format.xml  { render :xml => @line_item,
         :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @line_item.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.xml
  def update
    
    @cart = current_cart.id
    product = (params[:id])
    @line_item = LineItem.where({:product_id => product, :cart_id => @cart}).last
    @quantity = @line_item[:quantity]
    @quantity -= 1
    @quantity
    @line_items_quantity = LineItem.select(:quantity).where({:cart_id => @cart})    

    respond_to do |format|
      if (@line_item.update_attributes(:quantity => @quantity))&&(@quantity > 0) #@line_item.update_attributes(params[:line_item])
        format.html { redirect_to(store_url, :notice => 'Line item was successfully updated.') }
        
        format.js   #{ @current_item = @line_item }
        format.json #{ render action: 'show', status: :created, location: @line_item }
        #format.json { render action: 'show', status: :created, location: @line_item }
        format.xml  { head :ok }
      else
         @line_item.destroy

      if @line_items_quantity.empty?
         format.js {render inline: "location.reload();" }
       else      
      format.js 

        #format.html { redirect_to(store_url)}
        #format.html { render :action => "delete" } #format.html { render :action => "edit" }
        #format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
                
      end         
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.xml
  def destroy
    
    @cart = current_cart.id
    product = (params[:id])

    @line_item = LineItem.where({:product_id => product, :cart_id => @cart}) #POZIVANJE IZ TABELE SA USLOVOM
    
    @line_item    

    @line_item.destroy(@line_item)

    respond_to do |format|
      format.html { redirect_to (store_url) } #vraca na trenutnu korpu kupca
      format.xml  { head :ok }
    end
  end
end