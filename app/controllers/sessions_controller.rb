class SessionsController < ApplicationController

  def omniauth
    if user = User.from_omniauth(request.env['omniauth.auth'])
      if user.role == "admin"
        login(user)
        redirect_to admin_dashboard_index_path
      elsif user && user.authenticate(params[:password])
        login(user)
        redirect_to user_path(user)
      else
        flash[:warning] = "Unable to authenticate using your Google account. Please try again"
        redirect_to users_login_path
      end
    else
      flash[:warning] = "Unable to authenticate using your Google account. Please try again"
      redirect_to users_login_path
    end
  end

  def new
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      if user.role == "admin"
        login(user)
        flash[:success] = "Logged in as an admin"
        redirect_to admin_dashboard_index_path
      elsif user && user.authenticate(params[:password])
        login(user)
        flash[:success] = "Logged in successfully"
        redirect_to user_path(user.id)
      end
    else
      flash[:warning] = "Invalid credentials. Please try again."
      redirect_to users_login_path
    end
  end

  def logout
    message = "Your session has expired. Please login again." if params[:timeout].present?
    message = "You have successfully logged out" if params[:timeout].nil?
    log_out_user
    flash[:info] = message
    redirect_to users_login_path
  end
  
  private

  def user_params
    params.permit(:username, :password)
  end
end