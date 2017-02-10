class Listing < ActiveRecord::Base

	has_attached_file :image, styles: { medium: "200x", thumb: "100x100>" }, default_url: "default.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :state, :macro_category, presence: true, :if => :active_or_first?
  # validates :macro_category, presence: true, :if => :active_or_macro?
  validates :category, presence: true, :if => :active_or_category?
  validates :sub_category, presence: true, :if => :active_or_sub?


  validates :price, :short_description, :key_definition, presence: true, :if => :active?
  # Make sure price is a number and is >0
  validates :price, numericality: { greater_than: 0 }, :if => :active?
  # Make sure there is an image
  validates_attachment_presence :image, :if => :active?

  def active?
    status == 'active'
  end

  def active_or_first?
    status.include?('first') || active?
  end

  def active_or_category?
    status.include?('category') || active?
  end

  def active_or_sub?
    status.include?('sub_category') || active?
  end

  # Listing - User database relationship
  belongs_to :user
  # Order - Listing database relationship
	has_many :orders

end
