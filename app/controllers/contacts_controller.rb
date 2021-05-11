class ContactsController < ApplicationController
  def index
    @contacts = Contact.includes(:country, :help_center)
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to contacts_path, status: :moved_permanently, notice: 'success'
    else
      render :new, status: :unprocessable_entity, alert: 'fail'
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to contacts_path, status: :moved_permanently, notice: 'success'
    else
      render :new, status: :unprocessable_entity, alert: 'fail'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:country_id, :help_center_id, phones: [])
  end
end
