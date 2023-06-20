import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alerts"
export default class extends Controller {
  connect() {
    console.log("welcome to alerts controller")
  }
}

var _notice, _alert;
var div_notice, div_alert;
var seconds = 0;
var timer = 0;

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