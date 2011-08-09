class Stage < ActiveRecord::Base
  belongs_to :project
  has_many :tasks
  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :max_length => 100

  def time_estimate
    tasks.collect(&:time_estimate).inject(0.0) {|a,b| a + b.to_f }
  end
end

