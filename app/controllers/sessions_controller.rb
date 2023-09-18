class SessionsController < ApplicationController

  def omniauth
    if user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id 
    end
    redirect_to user_path(user)
  end
end