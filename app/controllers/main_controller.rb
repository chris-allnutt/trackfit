class MainController < ApplicationController
  def index
    @email_address = session[:email_address] 
    @workout_days = [
      {
        :name => 'Today',
        :date => Date.today.to_s
      },
      {
        :name => 'Yesterday',
        :date => Date.today-1
      },
      {
        :name => 'Two Days Ago',
        :date => Date.today-2
      }
    ]
  end
end
