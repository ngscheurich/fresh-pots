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

export function useXHR(
  selector,
  loadURL,
  flash_message = null,
  errorURL = null
) {
  const node = document.querySelector(selector);

  if (node) {
    node.addEventListener("submit", event => {
      event.preventDefault();

      const form = event.target;
      const xhr = new XMLHttpRequest();
      const fd = new FormData(form);

      xhr.addEventListener("load", event => {
        Turbolinks.visit(loadURL);
      });

      xhr.addEventListener("error", event => {
        const urlToVisit = errorURL === null ? loadURL : errorURL;
        Turbolinks.visit(urlToVisit);
      });

      xhr.open("POST", form.action);
      xhr.setRequestHeader("Flash-Message", encodeURIComponent(flash_message));
      xhr.send(fd);
    });
  }
}

export function disablePlaceholderOptions() {
  document
    .querySelectorAll("option[value='']")
    .forEach(option => (option.disabled = true));
}
