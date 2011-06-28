class Project < ActiveRecord::Base

  belongs_to :customer
  belongs_to :user

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :max_length => 100
end

