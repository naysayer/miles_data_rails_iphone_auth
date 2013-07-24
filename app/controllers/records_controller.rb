# This file is part of Miles Datas.
# 
# Miles Datas is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# Miles Datas is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see 
# <http://www.gnu.org/licenses/>.
#
# @author Johnathan Pulos <johnathan@missionaldigerati.org>
# @copyright Copyright 2013 Missional Digerati
#
class RecordsController < ApplicationController
	# Add authentication
	#
	before_filter :authenticate, :except => :create
	before_filter :api_authenticate, :only => :create
	
  # GET /records
  # GET /records.json
  def index
		puts params[:year]
		if params[:year]
			start_date = DateTime.new(params[:year].to_i, 1, 1)
			finish_date = DateTime.new(params[:year].to_i, 12, 31)
			@records = Record.where(["created_at >= ? AND created_at <= ?", start_date, finish_date]).order("created_at DESC")
		else
			@records = Record.order("created_at DESC")
		end 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @records }
			format.csv { send_data @records.as_csv }
    end
  end

  # GET /records/1/edit
  def edit
    @record = Record.find(params[:id])
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(params[:record])

    respond_to do |format|
      if @record.save
        format.json { render json: @record, status: :created, location: @record }
      else
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /records/1
  # PUT /records/1.json
  def update
    @record = Record.find(params[:id])

    respond_to do |format|
      if @record.update_attributes(params[:record])
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { head :no_content }
    end
  end
	
	protected

		def authenticate
			authenticate_or_request_with_http_basic do |username, password|
		    username == BASIC_AUTH['username'] && password == BASIC_AUTH['password']
		  end
		end
		
		def api_authenticate
			render(json: {:error => "401 Forbidden"}, :status => :forbidden) if params['api_key'].nil? || params['api_key'] != API_AUTH['key']
		end
end
