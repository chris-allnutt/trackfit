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
end
