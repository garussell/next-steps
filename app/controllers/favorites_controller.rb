class FavoritesController < ApplicationController

  def create
    @user = current_user
 
    @favorite = @user.favorites.create(favorite_params) 
    if @favorite.save
      flash[:success] = "Provider added to favorites"
      redirect_back(fallback_location: user_path(@user))
    elsif duplicate? 
      flash[:warning] = "Provider already added to favorites"
      redirect_back(fallback_location: user_path(@user))
    else
      flash[:warning] = "Provider not added to favorites"
      redirect_back(fallback_location: user_path(@user))
    end
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
    params&.require(:favorite).permit(:category, :name, :description, :address, :website, :phone, :fees, :schedule)
  end

  def duplicate?
    @user.favorites.exists?(address: params[:favorite][:address])
  end
  
end