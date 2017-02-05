class Listing < ActiveRecord::Base

	has_attached_file :image, styles: { medium: "200x", thumb: "100x100>" }, default_url: "default.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :category, :price, :variety, :year, presence: true
  # Make sure price is a number and is >0
  validates :price, numericality: { greater_than: 0 }
  # Make sure there is an image
  validates_attachment_presence :image

  # Listing - User database relationship
  belongs_to :user
  # Order - Listing database relationship
	has_many :orders

end
