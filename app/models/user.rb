class User < ActiveRecord::Base
  validates :email_address,
    :presence => true,
    :uniqueness => true,
    :email => true

  has_many :workouts
end
