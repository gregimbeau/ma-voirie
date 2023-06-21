document.addEventListener('DOMContentLoaded', (event) => {
  let mapElement = document.getElementById('map');
  let latitude = parseFloat(mapElement.dataset.latitude);
  let longitude = parseFloat(mapElement.dataset.longitude);
  let address = mapElement.dataset.address;

  let map = L.map('map').setView([latitude, longitude], 16);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors'
  }).addTo(map);

  L.marker([latitude, longitude]).addTo(map)
      .bindPopup(address)
      .openPopup();
});
