require 'test_helper'

class WorkoutControllerTest < ActionController::TestCase
  test "creates workout entry for existing user" do
    track_day = Date.today.to_s(:db)

    params = {
      :email_address => users(:batman).email_address,
      :workout_date => track_day
    }

    post(:track, params)

    workout = users(:batman).workouts.find_by_worked_out_on(params[:workout_date])

    assert flash[:notice] == "Thank you for using TrackFit, your workout has been tracked!"
    assert_not_nil workout, "Did not create workout for existing user"
  end

  test "creates workout for a user that does not exist" do
    track_day = Date.today.to_s(:db)

    params = {
      :email_address => "robin@mailtrust.com", #this cannot be a name in the fixtures
      :workout_date => track_day
    }

    post(:track, params)

    user = User.find_by_email_address(params[:email_address])
    workout = user.workouts.find_by_worked_out_on(params[:workout_date])

    assert flash[:notice] == "Thank you for using TrackFit, your workout has been tracked!"
    assert_not_nil workout, "Did not create workout for new user"
  end

  test "sets error when workout has already been tracked for the provided day" do
    # need to figure out how to mock/stub models for this
    track_day = Date.today
    users(:batman).workouts.create(:worked_out_on => track_day)

    params = {
      :email_address => "batman@mailtrust.com",
      :workout_date => track_day.to_s(:db)
    }

    post(:track, params)

    assert flash[:error] == "You have already tracked your workout for #{track_day.to_formatted_s(:rails_default)}", "Didn't set flash alert for duplicate workout"
    assert_redirected_to "/" #this should be its own assertion with a mock for workout save
  end
  
  test "sets error when email address is invalid" do
    # need to figure out how to mock/stub models for this
    track_day = Date.today

    params = {
      :email_address => "batman@mailtrust",
      :workout_date => track_day.to_s(:db)
    }

    post(:track, params)

    assert flash[:error] == "Please provide a valid e-mail address."
    assert_redirected_to "/" #this should be its own assertion with a mock for workout save
  end

  test "redirects to / on error" do
    # need to figure out how to mock/stub models for this
    track_day = Date.today
    users(:batman).workouts.create(:worked_out_on => track_day)

    params = {
      :email_address => users(:batman).email_address,
      :workout_date => track_day
    }

    post(:track, params)

    assert_redirected_to "/", "Did not send user to root: \"/\" after error"
  end

  test "redirects to /review/:email_address on success" do
    # need to figure out how to mock/stub models for this
    track_day = Date.today.to_s(:db)

    params = {
      :email_address => users(:batman).email_address,
      :workout_date => track_day
    }

    post(:track, params)

    assert_redirected_to "/"
    # assert_redirected_to "/review/#{params[:email_address]}", "Did not send user to review: \"/review/:email_address\" after success"
  end
end
