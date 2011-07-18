class Customer < ActiveRecord::Base

  has_many :projects
  has_many :units, :dependent => :destroy

  accepts_nested_attributes_for :units, :reject_if => Proc.new { |attributes| attributes['name'].blank? && attributes['physical_address'].blank? && attributes['postal_address'].blank? && attributes['phones_attributes'].delete_if {|i,p| p['label'].blank? && p['number'].blank? }.empty? }

  validate :must_have_at_least_one_unit

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :max_length => 100

  def name
    units.first.name
  end

  def postal_address
    units.first.postal_address
  end

  def physical_address
    units.first.physical_address
  end

  def phones
    units.first.phones
  end

  def units_for_select
    units.sort_by {|u| name.to_s }.collect {|u| [u.name || u.customer.name, u.id]}
  end

  def users_for_select
    User.all.collect {|u| [u.email, u.id]}
  end

  def contacts
    units.collect(&:contacts).flatten!
  end

  def staff_members
    contacts.collect(&:user)
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

