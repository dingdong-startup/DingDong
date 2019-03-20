class StaticsController < ApplicationController
	def index
		@properties = Property.all
	end
end
