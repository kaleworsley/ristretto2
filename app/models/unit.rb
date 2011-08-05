class Unit < ActiveRecord::Base

  belongs_to :customer
  has_many :phones, :as => :phoneable, :dependent => :destroy
  has_many :contacts, :dependent => :destroy
  has_many :tickets, :dependent => :destroy

  attr_accessible :phones_attributes, :name, :physical_address, :position, :postal_address

  accepts_nested_attributes_for :phones, :reject_if => Proc.new { |attributes| attributes['label'].blank? && attributes['number'].blank? }

  default_scope order('position')

  def Unit.units_for_select
    options = {}
    Unit.find(:all, :include => :customer).each do |u|
      options[u.customer.name] = [] unless options[u.customer.name].present?
      options[u.customer.name].push([u.name, u.id])
    end
    options
  end
end

