class CreateExercises < ActiveRecord::Migration[6.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :reps
      t.integer :sets
      t.string :notes
      t.integer :weight
      t.belongs_to :workout
      t.timestamps
    end
  end
end
