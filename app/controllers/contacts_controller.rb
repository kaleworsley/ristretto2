class ContactsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :customer, :through => :current_user
  load_and_authorize_resource :contact, :through => :customer
  inherit_resources
  belongs_to :customer

  def create
    if params[:contact][:email].present?
      @user = User.invite!({:email => params[:contact][:email], :full_name => params[:contact][:full_name]}, current_user)
      params[:contact][:user_id] = @user.id
    end
    @contact = Contact.new(params[:contact])

    create! { customer_contacts_url(@customer) }
  end

  def update
    update! { customer_contacts_url(@customer) }
  end
end

