class Workout < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :worked_out_on , :scope => :user_id
end
