import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="api"
export default class extends Controller {
  connect() {
    console.log("Connection à l'api controller")
  }
}

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