document.addEventListener('DOMContentLoaded', (event) => {
  let mapElement = document.getElementById('map');
  let reports = JSON.parse(mapElement.dataset.reports);
  let map = L.map('map').setView([48.8217, 7.4843], 14);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap contributors'
  }).addTo(map);

  reports.forEach(function(report) {
    let latitude = parseFloat(report.latitude);
    let longitude = parseFloat(report.longitude);
    let popupContent = `<a href="/reports/${report.id}" class="text-blue-500" data-turbo="false">Signalement à ${report.address}</a>`;

    L.marker([latitude, longitude]).addTo(map)
    .bindPopup(popupContent)
    .openPopup();
  });
});
