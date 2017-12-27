// import Turbolinks from "turbolinks";

export function addSelectDefault(selector, text) {
  let node = document.querySelector(selector);

  if (node) {
    let shouldAdd = true;
    node.querySelectorAll("option").forEach(x => {
      if (x.selected) shouldAdd = false;
    });
    shouldAdd && addPlaceholder(node, text);
  }
}

function addPlaceholder(node, text) {
  const option = document.createElement("option");
  option.disabled = true;
  option.selected = true;
  option.append(text);

  node.prepend(option);
}

export function useXHR(selector, loadURL, errorURL) {
  const node = document.querySelector(selector);

  if (node) {
    node.addEventListener("submit", event => {
      event.preventDefault();

      const form = event.target;
      const XHR = new XMLHttpRequest();
      const FD = new FormData(form);

      XHR.addEventListener("load", event => {
        Turbolinks.visit(loadURL);
      });

      XHR.addEventListener("error", event => {
        console.log(event);
      });

      XHR.open("POST", form.action);
      console.log("Sending via XHR", XHR);
      XHR.send(FD);
    });
  }
}

export function disablePlaceholderOptions() {
  document
    .querySelectorAll("option[value='']")
    .forEach(option => (option.disabled = true));
}
