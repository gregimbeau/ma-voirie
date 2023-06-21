import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alerts"
export default class extends Controller {
  connect() {
    console.log("Controller du scrolling")
  }
}

window.addEventListener('scroll', (e)=>{
  var scrollY = window.scrollY;
  sessionStorage.setItem("scrollY", scrollY);
  sessionStorage.setItem("is_reloaded", true);
});

window.addEventListener("turbo:load", (e)=>{
  window.scrollTo(0,sessionStorage.getItem("scrollY"));
});

if (sessionStorage.getItem("is_reloaded")){
  window.scrollTo(0,sessionStorage.getItem("scrollY"));
}