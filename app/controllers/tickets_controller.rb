class TicketsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  inherit_resources
end

