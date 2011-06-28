class Customer < ActiveRecord::Base

  has_many :units, :conditions => { :default => nil }, :dependent => :destroy
  has_one :default_unit, :class_name => "Unit", :conditions => { :default => true }, :dependent => :destroy

  accepts_nested_attributes_for :units, :default_unit, :reject_if => proc { |attributes| attributes['name'].blank? unless attributes['default'] }

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :max_length => 100
end

