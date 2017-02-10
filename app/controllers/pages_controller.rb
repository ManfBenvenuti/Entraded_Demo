class PagesController < ApplicationController
  def about
  end

  def contact
  end

  def show_listings
  	category = params[:category]
  	sub_category = params[:sub_category]
  	@listings = Listing.where("category like ? and sub_category like ?", category, sub_category)
  end

end
