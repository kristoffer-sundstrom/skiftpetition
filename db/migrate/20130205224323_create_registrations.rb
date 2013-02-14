class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :weight_class_id
      t.string :name
      t.string :email
      t.string :phone
      t.integer :age
      t.string :club

      t.timestamps
    end
  end
end
