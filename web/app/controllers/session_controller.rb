class SessionController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by name: params[:session][:name].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user_urls_path(user.id)
    else
      flash[:danger] = "Invalid username/password"
      render :new
    end
  end

  def destroy
  	log_out
    flash[:success] = "You are logged out"
    redirect_to login_path
  end
end
