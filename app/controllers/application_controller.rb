require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from CanCan::AccessDenied, :with => :render_403

  protected
  def render_404
    respond_to do |format|
      format.html do
        render 'static/_not_found', :status => 404
      end
      format.xml do
        render :nothing => true, :status => '404'
      end
    end
  end

  def render_403
    respond_to do |format|
      format.html do
        render 'static/_access_denied', :status => 403
      end
      format.xml do
        render :nothing => true, :status => '403'
      end
    end
  end

end

