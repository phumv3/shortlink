class UrlsController < ApplicationController
  before_action :find_user, except: [:shortened]
  skip_before_action :require_login, :only => [:shortened]

  def index
    @urls = Url.where(:user_id => @user.id).all.order(created_at: :desc)
    @headers = {:short_url => "Short Url", :long_url => "Long Url", :click => "Click", :created_at => "Create Date", :updated_at => "Update Date"}
  end
  def new
    @url = Url.new
  end
  def create
    @url = Url.new(url_params)
    @url.generate_short_url
    while(!(Url.find_by short_url: @url.short_url).nil?)
      @url.generate_short_url
    end
    @url.click = 0
    if @url.save
      redirect_to user_urls_path
    else
      flash[:error] = @url.errors.full_messages
      redirect_to new_user_url_path
    end
  end

  def edit
    find_url
  end

  def update
    find_url
    @url.update(url_params)
    if @url.save
      redirect_to user_urls_path
    else
      flash[:error] = @url.errors.full_messages
      redirect_to edit_user_url_path(@user, @url.id)
    end
  end

  def destroy
    find_url
    check = @url.destroy
    if !check
      flash[:error] = @url.errors.full_messages
    end
    respond_to do |format|
      format.html {
        redirect_to user_urls_path(@user)
      }
    end
  end

  def shortened
    @url = Url.find_by_short_url params[:short_url]
    # raise @url.to_json
    if (@url)
      @url.click += 1
      @url.save
      redirect_to @url.long_url
    end
  end

  private
  def url_params
    params.require(:url).permit(:long_url,:user_id)
  end

  def find_url
    @url = @user.urls.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
