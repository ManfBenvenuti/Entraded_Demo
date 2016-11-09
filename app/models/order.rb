class Order < ActiveRecord::Base
	# validations for our Order data
	validates :address, :city, :state, presence: true

	# Order database relation with Listing database
	belongs_to :listing
	# Order - User database relationship
	belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
end
