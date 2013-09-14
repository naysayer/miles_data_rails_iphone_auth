class AddTokenDateToUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :token_generated_at, :datetime
  end

  def self.down
  	remove_colum :users, :token_generated_at
  end
end
