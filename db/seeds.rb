Record.destroy_all
records = YAML.load_file(File.join(Rails.root.to_s, "db", "records_seed.yml"))
records.each do |r|
  record = Record.new
	record.car = r["car"]
	record.reason = r["reason"]
	record.start_lat = r["start_lat"]
	record.start_long = r["start_long"]
	record.start_location = r["start_location"]
	record.start_odometer = r["start_odometer"]
	record.start_use_coords = r["start_use_coords"]
	record.stop_lat = r["stop_lat"]
	record.stop_long = r["stop_long"]
	record.stop_location = r["stop_location"]
	record.stop_odometer = r["stop_odometer"]
	record.stop_use_coords = r["stop_use_coords"]
	record.created_at = rand(10.years).ago
	record.save
end