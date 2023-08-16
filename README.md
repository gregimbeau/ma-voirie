   ### THP W11/12 - FINAL PROJECT - MA VOIRIE

![alt text](https://i.postimg.cc/9m03CFNR/Ma-Voirie-Banner.png)

Création de notre Projet Final en équipe.

Notre github : [TeamKiTu](https://github.com/TeamKiTu)

Lien du site en production : https://ma-voirie.herokuapp.com/ || https://mavoirie.fly.dev/

Lien du Trello : https://trello.com/b/skdmSvOz/ma-voiriefr

------------

## Description

* Application permettant de signaler rapidement les problèmes de voirie pour une ville spécifique et de mettre en relation facilement les utilisateurs avec les décisionnaires de la commune de Bouxwiller.

------------
## Application

Création de l’application MA-VOIRIE

#### Utilisation du framework tailwind et d'une base de données Postgresql

`rails new ma-voirie -d postgresql --css tailwind`

#### Réalisation de la base de donnée

- User (devise)
`rails g devise User`

- Report
`rails g scaffold Report`

- Comment
`rails g model Comment`
`rails g controller Comment`

- Reply
`rails g model Reply`
`rails g controller Reply`

- ReportLike
`rails g model ReportLike`
`rails g controller ReportLike`

- ContactMailer
`rails g model ContactMailer`
`rails g controller ContactMailer`

<img src="https://trello.com/1/cards/6486cc870a05bb4f9e951c1b/attachments/6495771c1a936150973e6ea4/previews/6495771d1a936150973e74fb/download/Test_blog_(4).png" width="1000">

#### Détails des routes

```ruby
Rails.application.routes.draw do

#Les routes générées par devise pour le CRUD des utilisateurs.
  devise_for :users

#Collection permet de rattacher la route confirmation à contact_mailer.
  resources :contact_mailer, only: [:new, :create] do
    collection do
      get :confirmation
    end
  end

#Les pages statiques du site sont des requêtes get #THP.
  get '/conditions' => 'static_pages#conditions'
  get '/home' => 'static_pages#home'
  get '/map' => 'static_pages#map'

#Les routes des commentaires et des likes sont imbriquées dans celle des signalements (la route d'un commentaire sera donc /reports/:report_id/comments(.:format)).
  resources :reports, except: [:edit] do
    resources :comments, only: [:create, :update, :destroy]
    resources :report_likes, only: [:create, :destroy]
  end

#La resources replies aurait pu être attaché aux comments pour les routes.
  resources :replies

#Ajout manuel de ces routes pour nous permettre de passer outre Devise pour nos utilisateurs via le controller, très important pour la gestion de notre BDD (notamment destroy).
  resources :users, only: [:show, :edit, :update, :destroy]

#Page d'accueil
  root to: "static_pages#home"

#Les routes du tableau admin (root to = accueil dashboard admin).
  namespace :admin do
    root to: 'admin#index'
    resources :users, :reports
  end
end
```

## Parcours utilisateur

L'utilisateur arrive sur le site via la static_page “Home” qui est une landing page reprenant un bref résumé du fonctionnement du site avec deux boutons "CTA" (call to action) permettant de consulter les signalements en cours ou à en déposer (en les invitant à s’inscrire ou à se connecter en premier lieu).

Lorsque l'utilisateur s’inscrit sur le site, il doit obligatoirement lire/cocher l’acceptation des CGU (un lien permettant d’y accéder est indiqué sur le formulaire et sur le footer présent sur toutes les pages).

Une fois enregistré puis connecté, l’utilisateur à donc accès à la création d’un signalement. Il peut également “liker” et commenter les signalements existants.

Lors de la création d'un signalement, l'utilisateur doit renseigner le titre et le contenu du signalement. Il doit également indiquer l'adresse et est aidé à sélectionner une adresse conforme sur la commune de Bouxwiller. Enfin il doit fournir de une à trois photos pour pouvoir créer son signalement.

Une fois le signalement créé, l’utilisateur est redirigé vers le show de son signalement. 

Après validation de celui-ci par l'administration, il apparaitra sur l’index et tous les utilisateurs pourront le voir en détail sur la page show dédié avec la génération de la map.

Enfin, depuis le footer, il est possible via un formulaire de contact, pour tout visiteur / utilisateur de contacter l’administration en complétant le formulaire associé. Un captcha est présent et obligatoire pour l'envoi du mail.

## Parcours administrateur

Les administrateurs peuvent faire les mêmes choses qu'un utilisateur connecté. Il s'agit des personnes choisies par la mairie pour réaliser le suivi des signalements.

Ils ont accès à un dashboard admin lorsqu'ils cliquent sur leur nom d'utilisateur à droite de la navbar. Celui-ci leur permet de voir la liste des utilisateurs mais également tous les signalements et leurs statuts.

Les administrateurs peuvent modifier les statuts des signalements et les supprimer si nécessaire. Ils peuvent également supprimer les comptes des utilisateurs tout en conservant les signalements qu'ils auraient éventuellement générés.

Ils reçoivent des emails lors de la création de signalements et doivent ensuite les valider ou non, en fonction des informations transmises et des priorités de la commune en matière de travaux.

Le rôle d'administrateur est attribué uniquement sur demande de la mairie aux webmasters. Ils n'ont pas le pouvoir de supprimer les autres comptes administrateurs.

## Détails des fonctionnalités

### Utilisation d'une API pour la recherche d'adresse

Afin de faciliter le traitement des signalements, nous nous sommes servis de l'API de recherche d'adresse du gouvernement (https://adresse.data.gouv.fr/api-doc/adresse) qui, grâce à un code javascript permet de limiter les recherches sur le secteur concerné et d’aiguiller au mieux l’utilisateur pour son signalement.

Les attributs retournés sont :

- **housenumber** : numéro avec indice de répétition éventuel (bis, ter, A, B)
- **street** : nom de la voie
- **postcode** : code postal

### Mise en place d'un dropzone pour la sélection des photos

Afin d'améliorer l'expérience utilisateur, nous avons mis en place une dropzone permettant, soit de sélectionner directement les photos souhaités soit de les glisser/déposer. Pour cela, nous nous sommes servis du code de lazaronixon (https://gist.github.com/lazaronixon/dca1b48c241422d6347f4b0c93bec739) et de la vidéo explicative de Deanin (https://www.youtube.com/watch?v=UVkMGnYhwzc).

### Fonctionnement de la map

Le site contient deux types de cartes :

- la première se trouve sur chaque page show de signalement et reprend l'adresse de celui-ci.
- la deuxième est une carte globale reprenant l'ensemble des adresses des signalements validés et permet d'en sélectionner pour retourner sur sa page show.

Chaque type de carte a un fichier javascript qui lui est propre.

De plus, nous nous servons de deux gems : la gem leaflet pour l’affichage de la map et la gem httparty pour les requêtes sur OpenStreetMap.

Une méthode dans le controller report permet de récupérer la latitude et la longitude en reprenant l'adresse indiquée dans le signalement.

```Ruby
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

Ces deux coordonnées sont rajoutés à l'objet Report créé :

```Ruby
def create
    @report = Report.new(report_params)
    coords = geocode_address(@report.address)
    @report.latitude = coords[:latitude]
    @report.longitude = coords[:longitude]
```

### Fonctionnement du captcha

Le site permet de contacter les administrateurs sans être connecté. Afin de limiter les risques d'abus ou de botting, nous avons mis en place un Captcha sur la page du formulaire de contact.

Pour cela nous utilisons la gem recaptcha. Des clefs d'API ont été créés et mises dans le fichier .env et un fichier javascript gère le fonctionnement du Captcha notamment au niveau des messages d'erreurs.

------------

## Prérequis

	  Ruby 3.0.0  
	  Rails 7.0.5
    
    gem "faker" ==> pour la réalisation du seed
    gem "devise" ==> pour la création de la table, du model, des controllers et des views "User"
    gem "table_print" ==> pour afficher les tables dans la console sous forme de tableaux ordonnés
    gem 'dotenv-rails' ==> pour stocker les clés d'API et les valeurs spécifiques
    gem "aws-sdk-s3" ==> pour la gestion du compte AWS nécessaire aux stockages des photos
    gem 'devise-i18n' ==> pour la traduction des informations transmises par devise en français
    gem 'recaptcha', require: 'recaptcha/rails' ==> pour la mise en place du Captcha
    gem 'leaflet-rails' ==> pour la mise en place des cartes affichant le signalement
    gem 'httparty' ==> permet de faciliter les requêtes sur l'API d'OpenStreetMap

------------

## L'équipe

- [NicolasCHIRON](https://github.com/NicolasCHIRON)
- [Videloff](https://github.com/Videloff)
- [SmartDevSource](https://github.com/SmartDevSource)
- [gregimbeau](https://github.com/gregimbeau)
- [NicolasVdev](https://github.com/NicolasVdev)
- Notre mentor: [Gillian Levert](https://github.com/GillianLEVERT) (ancien élève de THP)
