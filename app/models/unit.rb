class Unit < ActiveRecord::Base

  belongs_to :customer
  has_many :phones, :as => :phoneable

  attr_accessible :phones_attributes, :name, :physical_address, :position, :postal_address

  accepts_nested_attributes_for :phones, :reject_if => Proc.new { |attributes| attributes['label'].blank? && attributes['number'].blank? }

  default_scope order('position')
end

