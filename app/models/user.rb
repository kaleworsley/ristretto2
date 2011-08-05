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

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :staff, :full_name, :phones_attributes, :password, :password_confirmation, :remember_me

  accepts_nested_attributes_for :phones, :reject_if => proc { |attributes| attributes['label'].blank? && attributes['number'].blank? }

  def with_phones
    self.phones.build
    self
  end

  def User.users_for_select
    all.collect {|u| [u.email, u.id]}
  end

  def to_s
    "#{full_name} <#{email}>"
  end
end

