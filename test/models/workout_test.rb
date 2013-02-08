require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase
  test "does not save more than one workout per day per user" do
    workout = Workout.create(:worked_out_on => Date.today, :user_id => 1)

    assert Workout.create(:worked_out_on => Date.today, :user_id => 1)
  end
end
