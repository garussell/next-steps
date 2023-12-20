class FavoritesController < ApplicationController

  def create
    @user = current_user || User.find(params[:user_id])
    @favorite = @user.favorites.new(favorite_params)
  
    if @favorite.save
      flash[:success] = "Provider added to favorites"
    elsif duplicate?
      flash[:warning] = "Provider already added to favorites"
    else
      flash[:warning] = "Provider not added to favorites"
      flash[:errors] = @favorite.errors.full_messages
    end
  
    redirect_back(fallback_location: user_path(@user))
  end
  

  def destroy
    @user = current_user
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    flash[:success] = "Provider removed from favorites"
    redirect_to user_path(@user)
  end

  private

  def favorite_params
    params.require(:favorite)&.permit(:category, :name, :description, :address, :website, :phone, :fees, :schedule)
  end

  def duplicate?
    @user.favorites.exists?(address: params[:favorite][:address])
  end
  
end