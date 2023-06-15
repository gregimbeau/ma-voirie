class ContactMailerController < ApplicationController
  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)
  
    if @contact_message.valid?
      ContactMailer.contact_message(@contact_message).deliver_now
      redirect_to confirmation_contact_index_path, notice: 'Message envoyé avec succès.'
    else
      render :new
    end
  end
  
  
  

  def confirmation
  end
  
  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message)
  end
end
