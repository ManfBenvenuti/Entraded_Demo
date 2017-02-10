class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  # Check that the user is signed in
  before_action :authenticate_user!
  #after_action :initialize_status, only: :create

  # Orders actions that correspond to same name views
  def sales
    @orders = Order.where('"orders"."seller_id" = ? AND "orders"."status" NOT LIKE ?', current_user, "sold").order("created_at DESC")
    @orders_sold = Order.where('"orders"."seller_id" = ? AND "orders"."status" LIKE ?', current_user, "sold").order("created_at DESC")

  end
  def purchases
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
    @orders_bought = Order.where('"orders"."buyer_id" = ? AND "orders"."status" LIKE ?', current_user, "sold").order("created_at DESC")
  end


  # # GET /orders
  # # GET /orders.json
  # def index
  #   @orders = Order.all
  # end

  # # GET /orders/1
  # # GET /orders/1.json
  # def show
  # end

  # GET /orders/new
  def new
    @order = Order.new
    # Use the Listing id from the URL to identify the one that is being ordered
    @listing = Listing.find(params[:listing_id])
  end

  # # GET /orders/1/edit
  # def edit
  # end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    # Use the Listing id from the URL to identify the one that is being ordered
    @listing = Listing.find(params[:listing_id])
    # Define the seller param
    @seller = @listing.user

    # buyer_id listing_id and seller_id columns set when an Order is created
    @order.listing_id = @listing.id
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id
    @order.status = "processing"

    respond_to do |format|
      if @order.save
        #Temporaneamente disattivato per testare in production
        #UserMailer.received_order(@seller, @order).deliver_now

        format.html { redirect_to purchases_orders_path(@orders_id), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    @order = Order.find params[:id]
    @order.status = "negotiating"
    @order.save
    redirect_to sales_orders_path
  end

  def refuse
    @order = Order.find params[:id]
    @order.status = "refused"
    if @order.save
      #Temporaneamente disattivato per testare in production
      #UserMailer.refused_order(@order.buyer, @order).deliver_now
    end
    redirect_to sales_orders_path
  end

  def conclude
    @order = Order.find params[:id]
    @order.status = "sold"
    @order.save
    redirect_to sales_orders_path
  end

  # # PATCH/PUT /orders/1
  # # PATCH/PUT /orders/1.json
  # def update
  #   respond_to do |format|
  #     if @order.update(order_params)
  #       format.html { redirect_to @order, notice: 'Order was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @order }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @order.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /orders/1
  # # DELETE /orders/1.json
  # def destroy
  #   @order.destroy
  #   respond_to do |format|
  #     format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:address, :city, :state)
    end

    # Set status in processing after create (get order by params)
    def initialize_status
      @order = Order.find(params[:id])
      @order.status = "processing"
      @order.save
    end
end
