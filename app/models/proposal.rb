class Proposal < ActiveRecord::Base
  belongs_to :project

  has_many :stakeholders, :through => :project
  has_many :stages, :through => :project
  has_many :team_members, :through => :project

  attr_accessor :team_ids

  accepts_nested_attributes_for :project

  before_save :create_stakeholders

  protected

  def create_stakeholders
    if self.team_ids.present?
      ids = self.team_ids.delete_if(&:blank?).collect(&:to_i).delete_if {|id| self.team_member_ids.include? id }
      ids.each do |id|
        Stakeholder.create(:user_id => id, :project_id => self.project_id)
      end
    end
  end
end

