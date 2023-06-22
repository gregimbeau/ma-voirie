class ReportMailer < ApplicationMailer
  default from: "gregimbeau@gmail.com"

  def report_confirmation(user)
    @user = user
    @url = "https://ma-voirie.herokuapp.com/"
    mail(to: @user.email, subject: "Merci pour votre signalement !")
  end

  def admin_report_notification(user)
    @user = user
    @url = "https://ma-voirie.herokuapp.com/"
    mail(to: "adminpcthp@yopmail.com", subject: "Nouveau signalement !")
  end
end
