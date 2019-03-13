class Property < ApplicationRecord
	belongs_to :agent
	belongs_to :agency
	belongs_to :area

	has_many :visits
	has_many_attached :images

end
