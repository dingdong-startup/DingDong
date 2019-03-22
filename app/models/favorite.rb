class Favorite < ApplicationRecord
	belongs_to :tenant
	belongs_to :property

end
