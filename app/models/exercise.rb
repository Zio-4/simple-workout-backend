class Exercise < ActiveRecord::Base
    belongs_to :workout

    def self.render_all
        self.all.map {|e| {
             name: e.name,
             reps: e.reps,
             sets: e.sets,
             notes: e.notes,
             weight: e.weight,
             workout_id: e.workout_id,
             id: e.id
           }}
     end

     def self.find_by_path(path)
        id = path.split("/exercises/")[1].to_i
        Exercise.all.where("id = #{id}")
     end
end