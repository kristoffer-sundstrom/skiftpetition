class CreateWeightClasses < ActiveRecord::Migration
  def change
    create_table :weight_classes do |t|

      t.string :beginner_elite, :default => nil
      t.string :gender
      t.string :weight
      t.string :age
      t.integer :id

      t.timestamps
    end
  end
end
