class ContactMailerController < ApplicationController
  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)
    @contact_message.captcha = params['g-recaptcha-response']
    
    if verify_recaptcha(model: @contact_message) && @contact_message.save
      ContactMailer.contact_message(@contact_message).deliver_now
      redirect_to confirmation_contact_index_path, notice: 'Message envoyé avec succès.'
    else
      @contact_message.errors.add(:captcha, 'Veuillez remplir le captcha') unless verify_recaptcha(model: @contact_message)
      render :new, status: :unprocessable_entity
    end
  end


  def confirmation
  end
  
  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message, :captcha)
  end
end
