class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def index
    @users = User.all
  end

	def new
		@user = User.new
	end

	def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Register success"
      redirect_to login_path
    else
      @user.errors.each do |key, value|
        flash[key] = key.to_s + ": " +  value
      end
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
