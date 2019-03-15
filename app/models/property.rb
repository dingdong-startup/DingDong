class Property < ApplicationRecord
	belongs_to :agent
	belongs_to :agency
	belongs_to :area

	has_many_attached :images
<<<<<<< HEAD
	has_many :visits
=======

	has_many :visits

>>>>>>> dev
end
