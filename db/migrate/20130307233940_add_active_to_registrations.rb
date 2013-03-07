class AddActiveToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :active, :boolean, :default => true
  end
end
