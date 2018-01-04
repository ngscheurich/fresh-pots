export function clearModal() {
  const modal = document.querySelector(".ReactModal__Overlay");
  if (modal) modal.parentNode.removeChild(modal);

  const app = document.querySelector("#app");
  if (app) app.classList.remove("is-frosted");
}

export function userID() {
  const match = document.cookie.match(/user_id=(\d)/);
  if (match) {
    return match[1];
  } else {
    return "";
  }
}
