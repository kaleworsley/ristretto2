class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :token_authenticatable

  has_many :phones, :as => :phoneable
  has_many :contacts, :uniq => true
  has_many :units, :through => :contacts, :uniq => true
  has_many :employers, :through => :units, :uniq => true, :source => :customer
  has_many :stakeholders
  has_many :projects, :through => :stakeholders, :uniq => true
  has_many :project_customers, :through => :projects, :class_name => 'Customer', :source => :customer
  has_many :requested_tickets, :foreign_key => :requested_by_id, :class_name => 'Ticket'
  has_many :assigned_tickets, :foreign_key => :assigned_to_id, :class_name => 'Ticket'

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :staff, :full_name, :phones_attributes, :password, :password_confirmation, :remember_me

  accepts_nested_attributes_for :phones, :reject_if => proc { |attributes| attributes['label'].blank? && attributes['number'].blank? }

  scope :staff, where(:staff => true)

  def customers
    if staff
      Customer
    else
      Customer.where(:id => (employers + projects.collect(&:customer)).uniq.collect(&:id))
    end
  end

  def with_phones
    self.phones.build
    self
  end

  def User.users_for_select
    all.collect {|u| [u.to_s, u.id]}
  end

  def to_s
    "#{full_name} <#{email}>"
  end
end

