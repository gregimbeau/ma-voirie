import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Reply controller")
  }
}

function buttonClicks() {
  var reply_buttons = document.querySelectorAll("#reply_show");
  var reply_div = document.querySelectorAll("#reply_div");

  for (let i = 0 ; i < reply_buttons.length ; i++) {
    reply_buttons[i].addEventListener("click", (e) => {
      reply_div[i].classList.remove("hidden");
      console.log(i);
    });
  }
}

document.addEventListener("turbo:load", ()=>{
  buttonClicks();
});

buttonClicks();