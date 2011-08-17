class Ability
  include CanCan::Ability

  def initialize(user)
    if user.staff
      can :manage, :all
    else
      can :read, Customer, :id => user.employer_ids
      can :read, Customer, :id => user.project_customer_ids

      can :read, Contact, :unit => { :customer_id => user.employer_ids }
      can :read, Contact, :unit => { :customer_id => user.project_customer_ids }

      can :read, Project, :id => user.project_ids
    end
  end
end

