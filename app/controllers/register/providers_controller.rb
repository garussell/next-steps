class Register::ProvidersController < ApplicationController
  before_action :require_login

  def new; end

  def create
    if provider_params_valid?
      user = User.find_by(id: session[:user_id])
  
      if user
        @provider = Provider.create!(provider_params)
        user.update(provider: true, provider_id: @provider.id)
        flash[:success] = "Provider successfully created"
        redirect_to user_path(user)
      end
    else 
      flash[:warning] = "Invalid entries, please try again"
      redirect_to new_register_provider_path
    end
  end  

  def edit
    if !session[:user_id]
      flash[:warning] = "You must be logged in to access this page."
      redirect_to users_login_path
    else
      user = User.find_by(id: session[:user_id])
      @provider = Provider.find(params[:id])
    end
  end

  def update
    user = User.find_by(id: session[:user_id])
    @provider = Provider.find(params[:id])
  
    if @provider.update(provider_params)
      flash[:success] = "Provider successfully updated"
      redirect_to user_path(user)
    else
      flash[:warning] = "Invalid entries, please try again"
      redirect_to edit_register_provider_path(@provider)
    end
  end

  def destroy
    user = User.find_by(id: session[:user_id])
    provider = Provider.find(params[:id])
    provider.destroy
    flash[:success] = "Provider deleted successfully"
    redirect_to user_path(user)
  end  

  private

  def provider_params
    params.permit(:name, :description, :street, :city, :state, :zipcode, :phone, :fees, :schedule)
  end
    
  def provider_params_valid?
    !provider_params[:name].empty? && !provider_params[:phone].empty? && !provider_params[:street].empty? && !provider_params[:city].empty? && !provider_params[:state].empty? && !provider_params[:zipcode].empty? && !provider_params[:fees].empty? && !provider_params[:schedule].empty? && !provider_params[:description].empty?
  end

  def require_login
    unless logged_in?
      flash[:danger] = "You must be logged in to access this page."
      redirect_to users_login_path 
    end
  end
end