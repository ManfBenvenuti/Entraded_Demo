class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  # Devise keyword :authenticate_user! to control which pages require users to be signed in
  before_filter :authenticate_user! #, only: [:seller, :new, :create, :edit, :update, :destroy]
  # Check user to allow only specific Listing owners to access certain pages
  before_filter :check_user, only: [:edit, :update, :destroy]


  # Define the seller action
  # .order("created_at DESC") to show newest on top
  def seller
    @listings = Listing.where(user: current_user).order("created_at DESC")
  end

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all.order("created_at DESC")
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @listing.user_id = current_user.id
    @listing.save(:validate => false)
    redirect_to listing_listing_step_path(:listing_id => @listing.id, :id => "first")
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    # Set the user_id column when a new Listing is created
    @listing.user_id = current_user.id

    respond_to do |format|
      if @listing.save
        byebug
        format.html { redirect_to listing_listing_step_path(:listing_id => @listing.id, :id => "category"), notice: 'You are creating a Listing' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:category, :price, :image, :macro_category, :sub_category, :short_description, :long_description, :status, :classification, :key_definition, :properties, :brand, :equipment, :notes, :measurements, :quantity, :state)
    end

    # Allow only specific Listing owners to access certain pages
    def check_user
      if current_user != @listing.user
        redirect_to root_url, alert: "Sorry, this listing belongs to someone else"
      end
    end
end
