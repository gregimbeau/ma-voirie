class ReportMailer < ApplicationMailer
  default from: "gregimbeau@gmail.com"

  def report_confirmation(user)
    @user = user
    @url = "http://monsite.fr/login"
    mail(to: @user.email, subject: "Merci pour votre signalement !")
  end

  def admin_report_notification(user)
    @user = user
    @url = "http://monsite.fr/admin"
    mail(to: "adminpcthp@yopmail.com", subject: "Nouveau signalement !")
  end
end
