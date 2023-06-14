// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

var notice;
var div_alert;
var seconds = 0;
var timer = 0;

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

document.addEventListener("turbo:load", ()=>{
  div_alert = document.getElementById("show_alert");
  notice = div_alert.getAttribute("data-notice");
  if (notice == "true")
  {
    seconds = 0;
    div_alert.classList.remove("hidden");
  } else {
    div_alert.classList.add("hidden");
    seconds = 0;
  }
});

timer = setInterval(() => {
  console.log(seconds);
  seconds++;
  if (notice == "true" && seconds>=7)
  {
    div_alert.classList.add("hidden");
  }
}, 1000);