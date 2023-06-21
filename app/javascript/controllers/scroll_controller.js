import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alerts"
export default class extends Controller {
  connect() {
    console.log("Controller du scrolling")
  }
}

var scrollY;

window.addEventListener('scroll', (e)=>{
  scrollY = window.scrollY;
  console.log(scrollY);

});

window.addEventListener("turbo:load", (e)=>{
  window.scrollTo(0,scrollY);
});