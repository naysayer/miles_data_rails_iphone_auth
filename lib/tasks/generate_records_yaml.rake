namespace :db do
  desc "Generate a records yaml file for seeding the database"
  task :generate_records_yaml => :environment do
    require 'populator'
    require 'faker'
    require 'geocoder'
		require 'yaml'
    cities = ["Bakersfield","Berkeley","Beverly Hills","Fremont","Fresno","Hayward","Long Beach","Los Angeles",
							"Modesto","North Hollywood","Oakland","Ontario","Pasadena","Riverside","Roseville","Sacramento",
							"San Bernardino","San Diego","San Francisco","San Jose","San Rafael","Santa Barbara","Santa Clara",
							"Stockton","Torrance","Van Nuys","Ventura","Walnut Creek"]
		records = []				  
		(0...150).each do |i|
			record = {}
			start_city = cities.sample
			start_coords = Geocoder.coordinates(start_city+", California")
			stop_city = cities.sample
			stop_coords = Geocoder.coordinates(stop_city+", California")
			puts start_coords
			puts "something"
			puts start_city
			record["car"] = Populator.words(1..3).titleize
			record["reason"] = Populator.paragraphs(1..3)
			odometer_start = rand(1000...500000)
			odometer_end = odometer_start+rand(100...600)
			record["start_lat"] = start_coords[0]
			record["start_long"] = start_coords[1]
			record["start_location"] = start_city+", California"
			record["start_odometer"] = odometer_start
			record["start_use_coords"] = true
			record["stop_lat"] = stop_coords[0]
			record["stop_long"] = stop_coords[1]
			record["stop_location"] = stop_city+", California"
			record["stop_odometer"] = odometer_end
			record["stop_use_coords"] = true
			records << record
		end
		file = File.open(File.join(Rails.root, "db", "records_seed.yml"), "w")
		file.write(records.to_yaml)
		file.close
  end
end