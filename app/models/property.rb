class Property < ApplicationRecord
	belongs_to :agent
	belongs_to :agency
	belongs_to :area
end
