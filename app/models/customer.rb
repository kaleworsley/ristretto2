class Customer < ActiveRecord::Base

  has_many :projects, :dependent => :destroy
  has_many :units, :dependent => :destroy
  has_many :contacts, :through => :units
  has_many :tickets, :through => :units
  has_many :staff_members, :through => :contacts, :uniq => true, :source => :user
  has_one :default_unit, :class_name => 'Unit'

  accepts_nested_attributes_for :units, :reject_if => Proc.new { |attributes| attributes['name'].blank? && attributes['physical_address'].blank? && attributes['postal_address'].blank? && attributes['phones_attributes'].delete_if {|i,p| p['label'].blank? && p['number'].blank? }.empty? }

  validate :must_have_at_least_one_unit

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :max_length => 100

  delegate :postal_address, :physical_address, :phones, :to => :default_unit

  default_scope { includes({:default_unit => :phones}, :slug) }

  def name
    default_unit.try(:name) || units.first.name
  end

  def units_for_select
    units.sort_by {|u| name.to_s }.collect {|u| [u.name || u.customer.name, u.id]}
  end

  def users_for_select
    User.all.collect {|u| [u, u.id]}
  end

  def to_s
    name
  end

  def as_json(options = {})
    super(:methods => [:name, :postal_address, :physical_address, :phones])
  end

  protected

  def must_have_at_least_one_unit
    if units.size < 1 || units.first.name.blank?
      errors.add(:name, "Must have at least one unit with a name")
      units.build unless units.size > 0
      units.each {|u| u.phones.build }
      units.first.errors.add(:name, "must be present")
    end

  end

end

