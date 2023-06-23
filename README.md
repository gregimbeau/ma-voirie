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

## Parcours utilisateur
   * L'utilisateur arrivant sur le site peut directement voir la liste des signalements validés.
   * Il sera invité à créer un compte ou à se connecter pour signaler des problèmes, interagir avec les autres utilisateurs (via les commentaires notamment).
   * Les utilisateurs pourront voir l'évolution des demandes (de l'acceptation à la réalisation des travaux nécessaires), qui seront traités par les administrateurs en lien avec la ville.

------------

## Concrétement et techniquement

### La base de données est sous PostgreSQL.

### Tables :
    * Utilisateurs (administrateurs / participants)
    * Problème signalés - avec images attachées via ActiveStorage
    * Commentaires
    * Likes
    * Messagerie

### Front

   * Utilisation de TailWind pour le CSS.
   * Utilisation de Javascript pour une interface interactive.

### Backend

   Utilisation d'une API pour la recherche d'adresses et la géolocalisation pour l'affichage des signalements sur une carte.

------------

## MVP
   * Inscription au site et méthode d'authentification.
   * Visualisation des problèmes déjà validés pour les utilisateurs non connectés (selon date de création)
   * Possibilité de signaler un problème avec fourniture de photos obligatoire.
   * Validation de chaque signalement par l'équipe administrative.
   * Utilisation d'une API pour la sélection des adresses.
   * Possibilité de suivre ces demandes
   * Indication et possibilité de changements des statuts pour les décisionnaires (suivi de la réponse [validé / accepté / en cours / résolu])


------------

## La version finale
   * Affichage d'une carte avec les problèmes signalés et leur statuts
   * Système de messages privés
   * Possibilité de commenter / liker
   * Classement des problèmes selon vote
   * Les signalements ayant fait l'objet de travaux sont listés dans une page dédiée avec (avec ajout d'éléments sur les travaux + photos)
   * Décompte des signalements fait par chaque utilisateur.

------------

## Planning

- MVP
   * Lundi : Finition Trello / Figma / Lucid / analyse du marché
   * Mardi : Création de l’app avec Tailwind - Base de donnée - Mise en  production / Choix du front - kit UI / branchement de l'API
   * Mercredi : page index / page show report / page admin / mailer admin + users
   * Jeudi : validation report / page show users / page edit users / page contact
   * Vendredi : rspec - test W3C
- Version finale
    * Lundi : Ajout base de donnée complémentaire / Mise en place de la carte
    * Mardi : like / comment
    * Mercredi : messagerie
    * Jeudi : ajout de la page des travaux déjà réalisés
    * Vendredi : rspec - test W3C

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
