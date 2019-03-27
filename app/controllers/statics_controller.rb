class StaticsController < ApplicationController
	def index
		@properties = Property.all
	end

	def team
		@nico = { :image => "nico.jpg", :name => "Nicolas", :position => "Product Owner", :citation => "Le client avant tout, la team avant les clients." }
		@fred = { :image => "fred.jpg", :name => "Frédéric", :position => "Lead Dev", :citation => "A l'accouchement, les médecins ont crié: 'l'ordi avant les pieds !'" }
		@etienne = { :image => "etienne.jpg", :name => "Etienne", :position => "Petaflop", :citation => "J'assiste les ordis quand ils peinent à calculer." }
		@max = { :image => "max.jpg", :name => "Maxime", :position => "Growth Hacker", :citation => "On m'a dit d'arrêter, alors j'ai continué." }
		@greg = { :image => "greg.jpg", :name => "Greg", :position => "Business Dev", :citation => "Quand je ne démarche pas, je fais des tests !" }
		#@team_photos = ["nico.jpg", "fred.jpg", "max.jpg", "etienne.jpg", "greg.jpg"].shuffle
		@team = [@nico, @fred, @greg, @etienne, @max].shuffle
	end
end
