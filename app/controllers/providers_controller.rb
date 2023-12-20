class ProvidersController < ApplicationController
  def show
    @provider = NextStepsService.provider_details(params[:id], params[:category])
    @user = current_user
    @favorite = @user.favorites.find_by(user_id: @user.id) if @user
  end
end