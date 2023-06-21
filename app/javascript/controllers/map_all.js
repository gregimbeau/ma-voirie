document.addEventListener('DOMContentLoaded', (event) => {
  var mapElement = document.getElementById('map');

  console.log('Dataset:', mapElement.dataset.reports);

  var reports = JSON.parse(mapElement.dataset.reports);

  var map = L.map('map').setView([48.8217, 7.4843], 14);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap contributors'
  }).addTo(map);


  reports.forEach(function(report) {


    var latitude = parseFloat(report.latitude);
    var longitude = parseFloat(report.longitude);
  
    var popupContent = report.address ? 'Address: ' + report.address : 'No address provided';

    L.marker([latitude, longitude]).addTo(map)
    .bindPopup('Incident à ' + report.address)
    .openPopup();
  });
});
