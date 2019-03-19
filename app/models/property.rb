class Property < ApplicationRecord
	belongs_to :agent
	belongs_to :agency
	belongs_to :area

	has_many_attached :images
	has_many :visits

	has_many :favorites
	has_many :tenants, through: :favorites
end
