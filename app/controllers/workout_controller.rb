class WorkoutController < ApplicationController
  def track

    parsed_date = Date.parse(params[:date])

    user = User.find_or_create_by(:email_address => params[:email_address])
    workout = user.workouts.build(:worked_out_on => parsed_date)

    if !workout.save
      if workout.errors.has_key?(:worked_out_on) and workout.errors.get(:worked_out_on).include?("has already been taken")
        flash[:alert] = "You have already tracked your workout for #{parsed_date.to_formatted_s(:rails_default)}"
      else
        flash[:alert] = "Unable to save at this time. Please try again and contact and administrator if this persists."
      end

      redirect_to "/"
      return
    end

    redirect_to "/review/#{params[:email_address]}"
  end
end
