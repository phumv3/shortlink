class ApiController < ApplicationController
	skip_before_action :require_login
	skip_before_action :verify_authenticity_token
	before_action :authen
	include ApiHelper

	def urls
		@urls = Url.where(:user_id => @user.id).limit(params[:limit]).offset(params[:offset]).order(created_at: :desc)
		@urls.each do |url|
			url.short_url = request.protocol + request.host + ":" + request.port.to_s + "/" + url.short_url
		end
		render json: {"code": 200, "message":"success", "data": @urls}
		
	end

	def new_url
		@url = Url.new(:long_url => params[:long_url], :user_id => @user.id)
	    @url.generate_short_url
	    while(!(Url.find_by short_url: @url.short_url).nil?)
	    	@url.generate_short_url
	    end
	    @url.click = 0
	    if @url.save
	    	@url.short_url = request.protocol + request.host + ":" + request.port.to_s + "/" + @url.short_url
	      	render json: {"code": 200, "message":"success", "data": @url}
	    else
	      	render json: {"code": 400, "message":@url.errors.full_messages, "data":[]}
	    end
	end

	private
	def authen
		authenticate_or_request_with_http_basic  do |name, password|
	      	@user = User.find_by name: name
	      	if @user.authenticate(password)
	          	return true
	        else
	        	render json: {"code": 401, "message":"Access denied"}, status: 401
	        end 
	    end
	end
	

end
