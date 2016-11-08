class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  # Listing - User database relationship --> dependent: :destroy così se
  # cancelli lo user cancelli anche il listing
  has_many :listings, dependent: :destroy
  
end
