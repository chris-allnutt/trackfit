class MainController < ApplicationController
  def index
    @email_address = session[:email_address] 
    @workout_days = [
      {
        :name => 'Today',
        :date => 0
      },
      {
        :name => 'Yesterday',
        :date => '-1'
      },
      {
        :name => 'Two Days Ago',
        :date => '-2'
      }
    ]
  end
end
