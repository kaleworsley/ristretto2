class StaticController < ApplicationController

  def show
    @static = params[:static]
  end

end
