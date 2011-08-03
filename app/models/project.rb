class Project < ActiveRecord::Base

  belongs_to :customer
  belongs_to :user

  has_many :stakeholders

  validates_presence_of :state
  validates_presence_of :name

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :max_length => 100

  STATES = %w(lead proposed current postponed complete)

  STATES.each do |state|
    scope state.to_sym, where(:state => state)
  end

  def Project.states
    STATES
  end

  def Project.states_for_select
    STATES.collect {|s| [s.humanize, s]}
  end

end

