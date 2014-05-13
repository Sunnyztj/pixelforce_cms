class ContactsController < ApplicationController

  def new
    @contact_us = ContactUs.new
  end

  def create
    @contact_us = ContactUs.new params[:contact_us]
    if @contact_us.save
      redirect_to contact_path
    else
      render action: :new
    end
  end

end