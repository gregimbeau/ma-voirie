   [![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
   [![forthebadge](https://forthebadge.com/images/badges/uses-css.svg)](https://forthebadge.com)
   [![forthebadge](https://forthebadge.com/images/badges/powered-by-coffee.svg)](https://forthebadge.com)
   


   ### THP W11/12 - FINAL PROJECT - MA VOIRIE

![alt text](https://i.postimg.cc/9m03CFNR/Ma-Voirie-Banner.png)

Creation de notre Projet Final en équipe.

Notre github : [TeamKiTu](https://github.com/TeamKiTu)

Lien du site en production : https://ma-voirie.herokuapp.com/

Lien du Trello : https://trello.com/b/skdmSvOz/ma-voiriefr

------------

## Description

* Application permettant de signaler rapidement les problèmes de voiries pour une ville spécifique et de mettre en relation facilement les utilisateurs avec les décisionnaires de la commune concernée.

------------
# MA VOIRIE

Création de l’app MA-VOIRIE

Framework tailwind

- rails new ma-voirie --css tailwind

Liste des models/controllers 

- User (devise)  (création de la table des utilisateurs)
rails g devise User

- Report (création de la table des signalements)
rails g scaffold Report

- Comment (création de la table des commentaires)
rails g model Comment
rails g controller Comment

- Reply (création de la table des commentaires de commentaires)
rails g model Reply
rails g controller Reply

- ReportLike (création de la table des “likes” de signalements)
rails g model ReportLike
rails g controller ReportLike

- ContactMailer (création de la table message de contact)
rails g model ContactMailer
rails g controller ContactMailer

Routes

```
Rails.application.routes.draw do

#Les routes générés par devise pour le crud des utilisateurs
  devise_for :users

#Collection permet de rattacher la route confirmation à contact_mailer
  resources :contact_mailer, only: [:new, :create] do
    collection do
      get :confirmation
    end
  end

#les pages statiques du site sont en get #THP
  get '/conditions' => 'static_pages#conditions'
  get '/home' => 'static_pages#home'
  get '/map' => 'static_pages#map'

#Les routes des commentaires et des likes commenceront par reports puisqu'ils y 
sont attachés
  resources :reports, except: [:edit] do
    resources :comments, only: [:create, :update, :destroy]
    resources :report_likes, only: [:create, :destroy]
  end

# il aurait du être attaché aux comments pour les routes
  resources :replies

# Ajout manuel de ces routes pour nous permettre de passer outre Devise pour 
nos utilisateurs via le controller, très important pour la gestion de notre BDD (destroy)
  resources :users, only: [:show, :edit, :update, :destroy]

#page d'accueil
  root to: "static_pages#home"

#les routes du tableau admin (root to = accueil dash admin)
  namespace :admin do
    root to: 'admin#index'
    resources :users, :reports
  end
end
```
# Parcours utilisateurs

Arriver sur le site via la static_page “Home” qui est une landing page reprenant un bref résumé du fonctionnement du site avec deux boutons “CTA(call to action) permettant de consulter les signalements en cours ou à en déposer.
En les invitants à s’inscrire ou à se connecter en premier lieux.

Lorsqu’il s’inscrit sur le site, il est obligatoire de lire/cocher l’acceptation des CGU (un lien permettant d’y accéder est indiqué sur le formulaire et sur le footer présent sur toutes les pages)

Une fois enregistré puis connecté, l’utilisateur à donc accès à la création d’un signalement.

L’utilisateur à des contraintes validantes (création compte et signalements) qui sont présentes dans les models (cf photo pour exemple), de plus une api (celle du gouvernement : https://adresse.data.gouv.fr/api-doc/adresse) fonctionne avec un javascript sur le principe de “curl” permettant de limiter les recherches dans les adresses et d’aiguiller au mieux l’utilisateur pour son signalement.

Les attributs retournés sont : (API gouv)

- **housenumber** : numéro avec indice de répétition éventuel (bis, ter, A, B)
- **street** : nom de la voie
- **postcode** : code postal

```ruby
class Report < ApplicationRecord
  after_create :send_confirmation_email
  belongs_to :user
  enum :status, ["en cours de validation", "validé", "accepté","en cours","résolu"]

  validates :address, presence: true
  validates :content, presence: true, length: { minimum: 20, maximum: 550 }
  validates :title, presence: true, length: { minimum: 15, maximum: 60 }
```

Une fois le signalement créé, l’utilisateur est redirigé vers le show de son signalement, il le verra pour la dernière fois avant validation de l’administration du site. 
Statut : En cours de validation

Une fois le signalement validé (changement du statut) celui-ci apparaitra sur l’index et sur “sa” show; avec la génération de la map (uniquement sur le show).

#Fonctionne de la map

gem leaflet (pour l’affichage de la map) / gem httparty (tracker les coordonnées gps)

méthode dans le controller report (permet de réaliser un fichier des coordonnées GPS en Json)

```
def geocode_address(address)
    response = HTTParty.get("https://api-adresse.data.gouv.fr/search/?q=#{CGI::escape(address)}&limit=1")
    if response.code == 200
      coordinates = response.parsed_response["features"][0]["geometry"]["coordinates"]
      return { longitude: coordinates[0], latitude: coordinates[1] }
    else
      return { longitude: nil, latitude: nil }
    end
  end
```

De facto ajout dans le méthode create du même controller les coordonnées

```
def create
    @report = Report.new(report_params)
    coords = geocode_address(@report.address)
    @report.latitude = coords[:latitude]
    @report.longitude = coords[:longitude]
```

Fonctionnement avec cdn et script (présent sur l’application.html.erb) + 2 controllers JS qui permettent la géolocalisation du signalement et de l’afficher sur la map en le liant à l’adresse du signalement.

Maintenant que l’utilisateur est enregistré il peut donc créer un signalement mais aussi les “liker/unliker” et les commenter.
Cela permettrait à terme de classer les signalements par nombres de commentaires ou likes/unlikes (feature non implémentée)

Enfin, depuis le footer, il est possible, via un formulaire de contact, pour tout visiteur/utilisateur de contacter l’administration en complétant le formulaire associé. Un captcha est présent et obligatoire pour ce faire.

Voici son fonctionnement :

- gem recaptcha

Clé API (from google) mise dans le .env 

Création d’un controller

```
class ContactMailerController < ApplicationController

  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)
    if verify_recaptcha(model: @contact_message) && @contact_message.save
      ContactMailer.contact_message(@contact_message).deliver_now
      redirect_to confirmation_contact_mailer_index_path, notice: 'Message envoyé avec succès.'
    else
      if !verify_recaptcha(model: @contact_message)
        @contact_message.errors.add(:captcha, 'Veuillez remplir le captcha')
        @contact_message.captcha = nil
      end
      render :new, status: :unprocessable_entity
    end
  end

  def confirmation
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message).merge(captcha: params['g-recaptcha-response'])
  end

end
```

Ajout d’un controller javascript “optionnel”

------------

## Requirements
	  Ruby 3.0.0  
	  Rails 7.0.5
    
    gem "tailwindcss-rails", "~> 2.0"
    gem "dockerfile-rails", ">= 1.4", :group => :development
    gem "aws-sdk-s3"

------------

## L'équipe

- [NicolasCHIRON](https://github.com/NicolasCHIRON)
- [Videloff](https://github.com/Videloff)
- [SmartDevSource](https://github.com/SmartDevSource)
- [gregimbeau](https://github.com/gregimbeau)
- [NicolasVdev](https://github.com/NicolasVdev)
- Notre mentor: Gillian Levert (ancien THP)
