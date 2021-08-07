class Workout < ActiveRecord::Base
    has_many :exercises

    def self.render_all
       self.all.map {|w| {
            name: w.name,
            day: w.day,
            notes: w.notes,
            id: w.id,
            exercises: w.exercises.map {|e| {
                name: e.name,
                reps: e.reps,
                sets: e.sets,
                notes: e.notes,
                weight: e.weight,
                workout_id: e.workout_id,
                id: e.id
              }
          }}}
    end

    def self.find_by_path(path)
        id = path.split("/workout/")[1].to_i # ["http://localhost:9393", "3"]
        Workout.find_by_id(id) #use find by id method so that if it dosen't find a note with that id it returns nil instead of throwing an error
    end

end