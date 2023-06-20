import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="captcha"
export default class extends Controller {
  connect() {
    console.log("Welcome to captcha time")
  }
}

window.onload = function() {
  if (typeof grecaptcha !== "undefined") {
    grecaptcha.ready(function() {
      grecaptcha.reset();
    });
  }
}
document.addEventListener("turbo:load", function() {
  if (typeof grecaptcha !== "undefined") {
    grecaptcha.ready(function() {
      grecaptcha.reset();
    });
  }
  var contactForm = document.getElementById('contact_form');
  contactForm.addEventListener('submit', function(event) {
    if (grecaptcha.getResponse() == '') {
      event.preventDefault();
      alert('Merci de completer le reCAPTCHA');
    }
  });
});