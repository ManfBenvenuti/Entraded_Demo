class ListingStepsController < ApplicationController

	include Wicked::Wizard

	steps :first, :category, :sub_category, :details

	def show
		@listing = Listing.find(params[:listing_id])
    render_wizard
  end

  def update
    @listing = Listing.find(params[:listing_id])
    params[:listing][:status] = step.to_s
    params[:listing][:status] = 'active' if step == steps.last
    @listing.update_attributes(listing_params)
    render_wizard @listing
  end


  # def create
  #   @listing = Listing.create
  #   redirect_to wizard_path(steps.first, :listing_id => @listing.id)
  # end
  private

  def listing_params
    params.require(:listing).permit(:category, :price, :image, :macro_category, :sub_category, :short_description, :long_description, :status, :classification, :key_definition, :properties, :brand, :equipment, :notes, :measurements, :quantity, :state)
  end
end
