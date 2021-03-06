class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :who_bought]

  # GET /products
  # GET /products.json
  def index
    @cart = current_cart
    @products = Product.all

   
    end

  # GET /products/1
  # GET /products/1.json
  def show
    @cart = current_cart
  end

  # GET /products/new
  def new
    @cart = current_cart
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @cart = current_cart
  end

  # POST /products
  # POST /products.json
  def create
    @cart = current_cart
    @product = Product.new(product_params)

    @product.picture = params[:picture] # Assign a file like this, or


    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Proizvod je uspešno dodat.' }
        format.json { render :show, status: :created, location: @product }

       # @product.picture.url #('/public/images/file.png')
        #@product.picture.current_path # => 'path/to/file.png'
        #@product.picture_identifier # => 'file.png'

      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Proizvod je uspešno promenjen.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Proizvod je uspešno izbrisan.' }
      format.json { head :no_content }
    end
  end



  def who_bought #FEEDS ATOM
    @product = Product.find(params[:id])
    respond_to do |format|
      #format.atom
      format.xml { render :xml => @product }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :type_of_wine, :picture)
    end
end
