// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

var _notice, _alert;
var div_notice, div_alert;
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
  div_notice = document.getElementById("show_notice");
  _notice = div_notice.getAttribute("data");

  div_alert = document.getElementById("show_alert");
  _alert = div_alert.getAttribute("data");

  seconds = 0;

  if (_notice == "true")
  {
    div_notice.classList.remove("hidden");
  } else {
    div_notice.classList.add("hidden");
  }

  if (_alert == "true")
  {
    div_alert.classList.remove("hidden");
  } else {
    div_alert.classList.add("hidden");
  }

});

timer = setInterval(() => {
  seconds++;
  if (seconds>=4)
  {
    if (_notice == "true")
    {
      div_notice.classList.add("hidden");
    }
    if (_alert == "true")
    {
      div_alert.classList.add("hidden");
    }
  }

}, 1000);