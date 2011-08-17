class Phone < ActiveRecord::Base
  belongs_to :phoneable, :polymorphic => true


  def as_json(options = {})
    super(:only => [:number, :label])
  end
end

