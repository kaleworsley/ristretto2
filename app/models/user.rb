class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :token_authenticatable

  has_many :phones, :as => :phoneable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :full_name, :phones_attributes, :password, :password_confirmation, :remember_me

  accepts_nested_attributes_for :phones, :reject_if => proc { |attributes| attributes['label'].blank? && attributes['number'].blank? }

  def with_phones
    self.phones.build
    self
  end

end

