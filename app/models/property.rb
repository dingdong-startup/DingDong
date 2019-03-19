class Property < ApplicationRecord
	belongs_to :agent
	belongs_to :agency
	belongs_to :area

	has_many_attached :images
	has_many :visits


	def self.not_archived
		self.where(is_archived: false)
	end	

end
