class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.references :user, :null => false
      t.date :worked_out_on, :null => false

      t.timestamps
    end
    add_index :workouts, [:user_id, :worked_out_on], :unique => true
  end
end
