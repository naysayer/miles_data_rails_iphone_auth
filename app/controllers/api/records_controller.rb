class Api::RecordsController < ApplicationController

	before_filter :require_auth

	def index
		@records = Record.where(["user_id = ?", @user.id]).order("created_at DESC")
		respond_to do |format|
		  	format.json { render json: @records }
		end
	end
	
end
