class Application
    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
  
      # if req.path.match(/workouts/) && req.patch?    #/workout/:id
      #   workout = Workout.find_by_path(req.path)

      #   if workout
      #     data = JSON.parse(req.body.read)
      #     workout.update(data)

      #     resp.write({message: "workout successfully updated", workout: workout})
      #     resp.status = 200
      #   else
      #     resp.write "Invalid data"
      #     resp.status = 422
      #   end

      if req.path.match(/workouts/) && req.delete?  #/workout/:id
       
        workout = Workout.find_by_path(req.path)

        if workout && workout.destroy
          resp.write({message: "workout successfully deleted", workout: workout})
          resp.status = 200
        else
          resp.write "Workout does not exist"
          resp.status = 404
        end

      elsif req.path.match(/workouts/) && req.post?
        workout_hash = JSON.parse(req.body.read) #looks for the data that the front end sends to the server then parses it.
        workout = Workout.create(workout_hash)

        resp.write({message: "workout successfully created", workout: workout}.to_json)
        resp.status = 200

      elsif req.path.match(/workouts/) && req.get?

        #return [200, {"Content-Type" => "application/json"}, [{message: "request succesful", workouts: Workout.render_all}.to_json]]

        if req.path.split("/workouts/")[1] == nil
          resp.write({message: "success", workouts: Workout.render_all}.to_json)
          resp.status = 200
        else
          workout = Workout.find_by_path(req.path)

          resp.write({message: "workout successfully returned", workout: workout, exercises: workout.exercises}.to_json)
          resp.status = 200
        end

      # elsif req.path.match(/exercises/) && req.patch?
      #   exercise = Exercise.find_by_id(req.path)

      #   if exercise
      #     data = JSON.parse(req.body.read)
      #     exercise.update(data)
          
      #     resp.write({message: "exercise successfully updated", exercise: exercise})
      #     resp.status = 200
      #   else
      #     resp.write "Invalid data"
      #     resp.status = 422
      #   end
      
      elsif req.path.match(/exercises/) && req.delete?

        exercise = Exercise.find_by_path(req.path)

        if exercise && exercise.destroy
          resp.write({message: "exercise successfully deleted", exercise: exercise}.to_json)
          resp.status = 200
        else
          resp.write "Exercise does not exist"
          resp.status = 404
        end

      # elsif req.path.match(/exercises/) && req.post?
      #   exercise_hash = JSON.parse(req.body.read) 
      #   exercise = Exercise.create(exercise_hash)

      #   resp.write({message: "exercise successfully created", exercises: exercise}.to_json)
      #   resp.status = 200

      elsif req.path.match(/exercises/) && req.get?
        resp.write({message: "success", exercises: Exercise.render_all}.to_json)
        resp.status = 200
      else
        resp.write "Route not found"
        resp.status = 404
      end
      resp.finish
    end
  end