class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find_by(id: params[:id])
    @favorites = @user.favorites if @user
    @providers = Provider.where(id: @user.provider_id.to_i) unless @user.nil?
    if @user.nil? || current_user != @user
      flash[:warning] = "You must be logged in to access this page."
      redirect_to users_login_path
    end
  end  

  def create
    @user = User.new(user_params)
    
    if user_params_valid? && @user.save
      flash[:success] = "Account created with advanced features pending approval"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:warning] = "Invalid entries, please try again"
      redirect_to new_user_path
    end
  end

  def edit
    if !session[:user_id]
      flash[:warning] = "You must be logged in to access this page."
      redirect_to users_login_path
    else
      @user = User.find(params[:id])
      if @user.nil? || current_user != @user
        flash[:warning] = "You must be logged in to access this page."
        redirect_to users_login_path
      end
    end
  end
  
  def update
    @user = current_user
    
    if params[:user][:new_password] == params[:user][:password_verify]
      if @user.update(password: params[:user][:new_password])
        flash[:success] = "Your password has been updated successfully."
        redirect_to user_path(params[:id])
      end
    else
      flash[:danger] = "Invalid credentials.  Please try again."
      redirect_to edit_user_path(params[:id])
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    session[:user_id] = nil
    flash[:success] = "Your account has been successfully deleted."
    redirect_to root_path
  end
  
  def generate_pdf
    @user = current_user || User.find(params[:id])
    @favorites = @user.favorites

    pdf_filename = "#{@user.username}-Dashboard.pdf"
    pdf_file = Rails.root.join('tmp', pdf_filename)
  
    new_pdf = PdfGeneratorService.generate_pdf(@user, @favorites, pdf_file)
    send_file(pdf_file, filename: pdf_filename, type: 'application/pdf', disposition: 'inline')
  end
  
  private

  def user_params
    params.permit(:username, :password, :description)
  end
  
  def user_params_valid?
    !user_params[:username].empty? && !user_params[:password].empty? && user_params[:password] == params[:password_verify]
  end
end