Record.destroy_all

records = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "records.yml"))
records['records'].each do |r|
  puts r
  new_record = Record.create({car: r['car'], reason: r['reason'], start_lat: nil, start_location: r['start_location'], start_long: nil, start_odometer: r['start_odometer'], start_use_coords: false, stop_lat: nil, stop_location: r['stop_location'], stop_long: nil, stop_odometer: r['stop_odometer'], stop_use_coords: false})
	new_record.created_at = Date.parse(r['created_at'].to_s)
	new_record.save!
end