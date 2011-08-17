class TimeslicesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  inherit_resources
#  belongs_to :to, :polymorphic => true, :optional => true
end

