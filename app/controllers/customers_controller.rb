class CustomersController < ApplicationController
  before_filter :authenticate_user!
  inherit_resources
  load_and_authorize_resource
  respond_to :html, :json, :xml

  def new
    @customer.units.build(:position => @customer.units.size + 1)
    @customer.units.build(:position => @customer.units.size + 1)
    @customer.units.each {|u| u.phones.build }
    new!
  end

  def edit
    @customer.units.build(:position => @customer.units.size + 1)
    @customer.units.each {|u| u.phones.build }
  end
end

