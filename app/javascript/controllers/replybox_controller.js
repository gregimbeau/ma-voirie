import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Reply controller")
  }
}

function buttonsAnswerClicks() {
  var answer_buttons = document.querySelectorAll("#reply_show");
  var reply_div = document.querySelectorAll("#reply_div");

  if (answer_buttons!=null && reply_div!=null) {
    for (let i = 0 ; i < answer_buttons.length ; i++) {
      answer_buttons[i].addEventListener("click", (e) => {
        reply_div[i].classList.remove("hidden");
      });
    }
  }
}

function buttonsSendReplyClicks() {
  var reply_textareas = document.querySelectorAll("#textarea_reply");
  var reply_buttons = document.querySelectorAll("#btn_send_reply");

  var textarea_main_comment = document.querySelector("#textarea_main_comment");
  var button_main_comment = document.querySelector("#button_main_comment");

  if (reply_buttons!=null) {
    for (let i = 0 ; i < reply_buttons.length ; i++) {
      if (reply_textareas[i].value.length<1)
      {
        reply_buttons[i].setAttribute("disabled","disabled");
        reply_buttons[i].classList.remove("cstm-bg-action");
        reply_buttons[i].classList.remove("cstm-light");
        reply_buttons[i].classList.add("cstm-bg-dark");
        reply_buttons[i].async = true;
      } else {
        reply_buttons[i].removeAttribute("disabled");
        reply_buttons[i].classList.remove("cstm-bg-dark");
        reply_buttons[i].classList.add("cstm-bg-action");
        reply_buttons[i].classList.add("cstm-light");
        reply_buttons[i].async = true;
      }
    }
  }

  if (textarea_main_comment!=null) {
    if (textarea_main_comment.value.length < 1)
    {
      button_main_comment.setAttribute("disabled","disabled");
      button_main_comment.classList.remove("cstm-bg-action");
      button_main_comment.classList.remove("cstm-light");
      button_main_comment.classList.add("cstm-bg-dark");
      button_main_comment.async = true;
    } else {
      button_main_comment.removeAttribute("disabled");
      button_main_comment.classList.remove("cstm-bg-dark");
      button_main_comment.classList.add("cstm-bg-action");
      button_main_comment.classList.add("cstm-light");
      button_main_comment.async = true;
    }
  }
}

setInterval(() => {
  buttonsAnswerClicks();
  buttonsSendReplyClicks();
}, 100);