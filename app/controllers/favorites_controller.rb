class FavoritesController < ApplicationController

  before_action :authenticate_tenant!

  
  def index 
    @favorites = Favorite.where(tenant: current_tenant, is_liked: true)
  end

  def create
    favorite = Favorite.new(is_liked: true, property_id: params[:property_id], tenant: current_tenant)

    if favorite.save
      flash[:success] = "Cette annonce a bien été ajoutée à vos favoris"
      redirect_back(fallback_location: properties_path)
    else
      flash[:danger] = "Une erreur s'est produite, veuillez réessayer"
      redirect_back(fallback_location: properties_path)
    end
  end

  def update  
    if is_already_favorited
      @favorite.update_attributes(is_liked: false)
      flash[:light] = "Cette annonce a été retirée de vos favoris"
      redirect_back(fallback_location: properties_path)
    else is_already_unfavorited
      @favorite.update_attributes(is_liked: true)
      flash[:success] = "Cette annonce a été ajoutée à vos favoris"
      redirect_back(fallback_location: properties_path)
    end 
  end

  private

  def is_already_favorited
    @favorite = Favorite.find_by(is_liked: true, property_id: params[:property_id], tenant: current_tenant)
  end

  def is_already_unfavorited
    @favorite = Favorite.find_by(is_liked: false, property_id: params[:property_id], tenant: current_tenant)
  end
end
