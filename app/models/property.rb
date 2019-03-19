class Property < ApplicationRecord
	belongs_to :agent
	belongs_to :agency
	belongs_to :area

	has_many_attached :images
	has_many :visits


	def self.not_archived
    self.where(is_archived: false)
  end 

  def total_rent
  	self.price.to_i + self.charges.to_i
  end




end
