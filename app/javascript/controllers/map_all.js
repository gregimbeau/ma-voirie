document.addEventListener('DOMContentLoaded', (event) => {
  let mapElement = document.getElementById('map');
  console.log('Dataset:', mapElement.dataset.reports);
  let reports = JSON.parse(mapElement.dataset.reports);
  let map = L.map('map').setView([48.8217, 7.4843], 14);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap contributors'
  }).addTo(map);

  reports.forEach(function(report) {

    let latitude = parseFloat(report.latitude);
    let longitude = parseFloat(report.longitude);
    let popupContent = report.address ? 'Address: ' + report.address : 'No address provided';

    L.marker([latitude, longitude]).addTo(map)
    .bindPopup('Incident à ' + report.address)
    .openPopup();
  });
});