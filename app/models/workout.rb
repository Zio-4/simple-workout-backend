class Workout < ActiveRecord::Base
    #dependent attribute will make it so that any exercises associated with a particular instance of a workout will be deleted along with the workout
    has_many :exercises, dependent: :destroy

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
        id = path.split("/workouts/")[1].to_i # ["http://localhost:9393", "3"]
        w = Workout.find_by_id(id) #use find by id method so that if it dosen't find a note with that id it returns nil instead of throwing an error
    end

    #setter instance method will get called because of the key with the same name being passed from the front end.
    def exercises_attributes=(attributes)

        attributes.each do |e|
            self.exercises.build(e)
        end
    end

end