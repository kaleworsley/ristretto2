class Project < ActiveRecord::Base

  belongs_to :customer

  has_many :stakeholders, :dependent => :destroy
  has_many :team_members, :through => :stakeholders, :conditions => {:staff => true }, :source => :user, :class_name => "User"
  has_many :tasks
  has_many :stages

  has_one :proposal

  validates_presence_of :state
  validates_presence_of :name

  accepts_nested_attributes_for :tasks, :reject_if => Proc.new {|attributes| attributes['description'].blank? }
  accepts_nested_attributes_for :stages

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :max_length => 100

  default_scope { includes(:slug) }
  scope :state, Proc.new { |state| where(:state => state) }

  STATES = %w(lead proposed current postponed complete) | CONFIG[:project_states]

  STATES.each do |state|
    scope state.to_sym, where(:state => state)
  end

  def Project.states
    STATES
  end

  def Project.scopes
    STATES + %w(my all)
  end

  def Project.states_for_select
    STATES.collect {|s| [s.humanize, s]}
  end

  def create_proposal
    unless proposal.present?
      @proposal = self.build_proposal(:hourly_rate => CONFIG[:proposal_hourly_rate], :version => CONFIG[:proposal_version]).save!
      CONFIG[:project_stages].each do |stage|
        self.stages.build(:name => stage.humanize).save!
      end
      @proposal
    else
      proposal
    end
  end

end

