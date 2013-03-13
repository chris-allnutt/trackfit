class ReportController < ApplicationController
  def standings
    beginning_of_month = Date.current().at_beginning_of_month

    @report_data = []

    User.all().each do |user|
      user_name = user.email_address.split('@').first

      total_workouts = Workout.where(
        "user_id = :user_id AND worked_out_on >= :worked_out_on",
        {:user_id => user.id, :worked_out_on => beginning_of_month.to_s}
      ).count

      @report_data.push({
        "name" => user_name,
        "workouts" => total_workouts
      })
    end

    @report_data.sort_by!{ |a| -a['workouts'] }

    @report_date = Date.current().at_beginning_of_month
  end

  def winner
    @winner     = nil
    @start_date = nil
    @end_date   = nil

    if params[:start_date].blank? || params[:end_date].blank?
      flash[:notice] = "Please select a date range to determine a winner"
    else
      workout = Workout.where(
        'worked_out_on >= :start_date AND worked_out_on <= :end_date', 
        {:start_date => params[:start_date],
         :end_date   => params[:end_date]}
      ).order("RANDOM()").first

      if workout 
        @winner = User.find(workout.user_id).email_address.split('@').first
      else
        flash[:notice] = "No workouts were logged for this date range"
      end
      @start_date = params[:start_date]
      @end_date   = params[:end_date]
    end

  end
end
