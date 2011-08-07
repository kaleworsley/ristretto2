class Timeslice < ActiveRecord::Base
  belongs_to :timetrackable, :polymorphic => true
  belongs_to :created_by, :class_name => 'User'
  validates_presence_of :created_by_id
  validates_presence_of :started
  validates_presence_of :finished
end

