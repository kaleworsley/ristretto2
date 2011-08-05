class Ticket < ActiveRecord::Base
  belongs_to :assigned_to, :class_name => "User"
  belongs_to :requested_by, :class_name => "User"
  belongs_to :unit

  validates_presence_of :unit_id
  validates_presence_of :description

  STATES = %w(not_started open closed rejected)

  STATES.each do |state|
    scope state.to_sym, where(:state => state)
  end

  def Ticket.states
    STATES
  end

  def Ticket.states_for_select
    STATES.collect {|s| [s.humanize, s]}
  end
end

