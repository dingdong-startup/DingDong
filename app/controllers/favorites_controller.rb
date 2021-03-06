class FavoritesController < ApplicationController

  before_action :authenticate_tenant!

  
  def index 
    @favorites = Favorite.where(tenant: current_tenant, is_liked: true)
  end

  def create
    @favorite = Favorite.new(is_liked: true, property_id: params[:property_id], tenant: current_tenant)    
    @favorite_number = current_tenant.fav_properties.count

    if @favorite.save
      @property_id = params[:property_id]
      @favorite_id = @favorite.id
      
      respond_to do |format| 
        format.js 
        format.html do 
          flash[:success] = "Cette annonce a bien été ajoutée à vos favoris"
          redirect_back(fallback_location: properties_path)
        end
      end
    else
      flash[:danger] = "Une erreur s'est produite, veuillez réessayer"
      redirect_back(fallback_location: properties_path)
    end
  end

  def update  
    @favorite_number = current_tenant.fav_properties.count
    @property = Property.find(params[:property_id])
    @favorite = Favorite.find(params[:id])
    @property_id = params[:property_id]

    if @favorite.is_liked
      if @favorite.update_attributes(is_liked: false)
        respond_to do |format|
          format.js
          format.html do 
            flash[:light] = "Cette annonce a été retirée de vos favoris"
            redirect_back(fallback_location: properties_path)
          end
        end
      else
        flash[:danger] = "Une erreur s'est produite."
        redirect_back(fallback_location: properties_path)
      end
    else
      if @favorite.update_attributes(is_liked: true)
        respond_to do |format|
          format.js 
          format.html do 
            flash[:success] = "Cette annonce a été ajoutée à vos favoris"
            redirect_back(fallback_location: properties_path)
          end
        end
      else
        flash[:danger] = "Une erreur s'est produite."
        redirect_back(fallback_location: properties_path)
      end
    end 
  end

  private

end
