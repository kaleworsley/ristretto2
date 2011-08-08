class Stage < ActiveRecord::Base
  belongs_to :project
  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :max_length => 100
end

