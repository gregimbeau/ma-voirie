document.addEventListener('DOMContentLoaded', (event) => {
  var mapElement = document.getElementById('map');
  var latitude = parseFloat(mapElement.dataset.latitude);
  var longitude = parseFloat(mapElement.dataset.longitude);
  var address = mapElement.dataset.address;

  var map = L.map('map').setView([latitude, longitude], 16);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors'
  }).addTo(map);

  L.marker([latitude, longitude]).addTo(map)
      .bindPopup(address)
      .openPopup();
});
