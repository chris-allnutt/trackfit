class WorkoutController < ApplicationController
  def track

    session[:email_address] = params[:email_address];

    if (params[:workout_date].blank?)
      flash[:error] = "Please select a date."
      redirect_to "/"
      return
    end

    parsed_date = Date.parse(params[:workout_date])

    if(is_valid_email_addres(params[:email_address]))
      
      user = User.find_or_create_by(:email_address => params[:email_address])
      workout = user.workouts.build(:worked_out_on => parsed_date)

      if !workout.save
        if workout.errors.has_key?(:worked_out_on) and workout.errors.get(:worked_out_on).include?("has already been taken")
          flash[:error] = "You have already tracked your workout for #{parsed_date.to_formatted_s(:rails_default)}"
        else
          flash[:error] = "Unable to save at this time. Please try again and contact and administrator if this persists."
        end

        redirect_to "/"
        return
      end
    
    else
      flash[:error] = "Please provide a valid e-mail address."
      redirect_to "/"
      return
    end

    flash[:notice] = "Thank you for using TrackFit, your workout has been tracked!"

    # redirect_to "/review/#{params[:email_address]}"
    redirect_to "/"
  end
  
  private
  def is_valid_email_addres (email_address)
    return email_address =~ /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i
  end
  
end
