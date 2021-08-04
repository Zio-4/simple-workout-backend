class CreateWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :day
      t.text :notes
      t.timestamps
    end
  end
end
