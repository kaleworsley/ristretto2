class Unit < ActiveRecord::Base

  belongs_to :customer
  has_many :phones, :as => :phoneable

  attr_accessible :phones_attributes

  accepts_nested_attributes_for :phones, :reject_if => proc { |attributes| attributes['label'].blank? && attributes['number'].blank? }
end

