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
class Record < ActiveRecord::Base
  attr_accessible :car, :reason, :start_lat, :start_location, :start_long, :start_odometer, :start_use_coords, :stop_lat, :stop_location, :stop_long, :stop_odometer, :stop_use_coords
	attr_reader :distance
	
	# calculate the distance
	#
	def distance
		self.stop_odometer.to_i - self.start_odometer.to_i
	end
	
	# sets up the CSV
	#
	def self.as_csv(options = {})
	  CSV.generate(options) do |csv|
			titles = first.attributes.collect{|c| c[0]}
			titles.push("distance")
	    csv << titles
			total_distance = 0
	    all.each do |record|
				values = record.attributes.collect{|c| c[1]}
				values.push(record.distance)
	      csv << values
				total_distance += record.distance
	    end
			total_deduction = (total_distance*0.565).round(2)
			csv << ["Total Distance", total_distance]
			csv << ["Total Deduction", total_deduction]
	  end
	end
end
