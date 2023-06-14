class ContactMailer < ApplicationMailer
  def contact_message(contact_message)
    @contact_message = contact_message

    mail to: "grgbthp@yopmail.com", subject: "Nouveau Message MaVoirie"
  end
end
