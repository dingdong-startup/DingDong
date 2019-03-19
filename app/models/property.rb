class Property < ApplicationRecord
	belongs_to :agent
	belongs_to :agency
	belongs_to :area

	has_many_attached :images
	has_many :visits

<<<<<<< HEAD
	has_many :favorites
	has_many :tenants, through: :favorites
=======

	validates :title, 
			  :surface, 
			  :address, 
			  :room, 
			  :description, 
			  :price, 
			  :floor, 
			  :available_date, presence: true

	validates :room, numericality: { only_integer: true }
	validates :price, numericality: { only_integer: true }
	validates :surface, numericality: true
	validates :floor, numericality: { only_integer: true }
	validates :description, length: { minimum: 40 }
	validates :title, length: { minimum: 10 }

	def self.not_archived
    self.where(is_archived: false)
  end 

  def total_rent
  	self.price.to_i + self.charges.to_i
  end





>>>>>>> dev
end
