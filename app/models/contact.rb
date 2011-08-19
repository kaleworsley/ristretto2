class Contact < ActiveRecord::Base
  belongs_to :unit
  belongs_to :user

  validates_presence_of :user_id, :unless => Proc.new {|c| c.email.present? }
  validates_presence_of :unit_id
  #validates_presence_of :email, :unless => Proc.new {|c| c.user_id.present? || c.user_id.present? }

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true
  attr_accessor :email, :full_name
end

