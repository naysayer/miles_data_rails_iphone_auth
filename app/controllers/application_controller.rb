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
class ApplicationController < ActionController::Base
  protect_from_forgery
	after_filter :set_access_control_headers

	def set_access_control_headers 
		headers['Access-Control-Allow-Origin'] = '*' 
		headers['Access-Control-Request-Method'] = 'POST' 
	end

	def redirect_home
		redirect_to root_path
		flash[:notice] = "Unable to process your request"
	end

	def require_auth
		auth_token = request.headers["auth_token"]
		@user = User.find_by_authentication_token(auth_token)
		if @user
		  # if @user.auth_token_expired?
		  #   render :status => 401, :json => {:error => "Auth token expired"}
		  #   return false
		  # end
		else
		  render :status => 401, :json => {:error => "Please login to continue"}
		  return false
		end
	end
end
