class UserMailer < ApplicationMailer
  default from: "gregimbeau@gmail.com"

  def welcome(user)
    @user = user
    @url = "http://monsite.fr/login"
    mail(to: @user.email, subject: "Bienvenue sur le site MaVoirie de la commune de Bouxwiller!")
  end

  def password_changed(user)
    @user = user
    @url = "http://monsite.fr/login"
    mail(to: @user.email, subject: 'Votre mot de passe a bien été mis à jour')
  end
end




