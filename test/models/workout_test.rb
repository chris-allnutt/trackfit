require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase
  test "does not save more than one workout per day per user" do
    workout = Workout.create(:worked_out_on => Date.today, :user_id => 1)

    assert Workout.create(:worked_out_on => Date.today, :user_id => 1)
  end

  test "allows differnt users to save a workout on the same day" do
    today = Date.today
    Workout.create(:worked_out_on => today, :user_id => 1)
    assert Workout.create(:worked_out_on => today, :user_id => 1)
  end
end
