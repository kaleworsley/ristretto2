class Task < ActiveRecord::Base
  belongs_to :assigned_to, :class_name => "User"
  belongs_to :project
  belongs_to :stage
  has_many :timeslices, :as => :timetrackable, :dependent => :destroy

  validates_presence_of :description
  validates_presence_of :project_id

  STATES = %w(not_started started delivered accepted rejected) | CONFIG[:task_states]

  STATES.each do |state|
    scope state.to_sym, where(:state => state)
  end

  def Task.states
    STATES
  end

  def Task.states_for_select
    STATES.collect {|s| [s.humanize, s]}
  end
end

