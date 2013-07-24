class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.boolean :start_use_coords
      t.boolean :stop_use_coords
      t.text :start_location
      t.text :stop_location
      t.text :start_odometer
      t.text :stop_odometer
      t.text :reason
      t.text :start_lat
      t.text :start_long
      t.text :stop_lat
      t.text :stop_long
      t.text :car

      t.timestamps
    end
  end
end
