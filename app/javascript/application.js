// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

$(document).ready(function() {
  // Fonction pour gérer la saisie dans la zone de saisie
  function handleInput() {
    var inputValue = $('#addressInput').val();
    var apiUrl = `https://api-adresse.data.gouv.fr/search/?q=${inputValue}&type=street&postcode=67330&type=housenumber`;

    $.ajax({
      url: apiUrl,
      method: 'GET',
      dataType: 'json',
      success: function(response) {
        displayAddressResults(response);
      },
      error: function(xhr, status, error) {
        console.log('Erreur lors de la recherche d\'adresse : ' + error);
      }
    });
  }

  function displayAddressResults(response) {
    var results = response.features;
    var resultsList = $('#addressResults');
    resultsList.empty();

    var maxSuggestions = Math.min(results.length, 3);

    for (var i = 0; i < maxSuggestions; i++) {
      var address = results[i].properties.label;
      var listItem = $('<li class="hover:bg-orange-400">')
      .append($('<div class="ml-2 py-2 font-medium">').text(address));
      resultsList.append(listItem);
    }

    $('#addressResults li').click(function() {
      var selectedAddress = $(this).text();
      $('#addressInput').val(selectedAddress);
      $('#resultContainer').hide();
    });

    $('#resultContainer').show();
  }

  $('#addressInput').on('input', function() {
    handleInput();
  });
});

document.addEventListener("DOMContentLoaded", function() {
  var banner = document.getElementById('cookie-banner');
  var acceptButton = document.getElementById('accept-cookies');
  var declineButton = document.getElementById('decline-cookies');

  if (!localStorage.getItem('cookieConsent')) {
    banner.style.display = "block";
  }

  acceptButton.onclick = function() {
    localStorage.setItem('cookieConsent', 'accepted');
    banner.style.display = "none";
  }

  declineButton.onclick = function() {
    localStorage.setItem('cookieConsent', 'declined');
    banner.style.display = "none";
  }
});
