class Ticket < ActiveRecord::Base
  belongs_to :assigned_to, :class_name => "User"
  belongs_to :requested_by, :class_name => "User"
  belongs_to :unit

  has_many :timeslices, :as => :timetrackable, :dependent => :destroy

  validates_presence_of :unit_id
  validates_presence_of :description
  validates_presence_of :state

  accepts_nested_attributes_for :timeslices , :reject_if => Proc.new { |attributes| attributes['started'] == attributes['finished'] }

  default_scope order(:created_at)

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

  def requested_by_user?
    requested_by.present?
  end

  def requester
    if requested_by_user?
      requested_by.to_s
    else
      requested_by_name
    end
  end
end

