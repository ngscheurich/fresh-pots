import Turbolinks from "turbolinks";

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

export function useXHR(selector, nextURL) {
  const node = document.querySelector(selector);

  if (node) {
    node.addEventListener("submit", event => {
      event.preventDefault();

      const form = event.target;

      const xhr = new XMLHttpRequest();
      xhr.open("POST", form.action);
      xhr.setRequestHeader("Turbolinks-Referrer", window.location);

      xhr.addEventListener("load", event => {
        Turbolinks.visit(nextURL, { action: "replace" });
      });

      const data = new FormData(form);
      xhr.send(data);
    });
  }
}

export function disablePlaceholderOptions() {
  document
    .querySelectorAll("option[value='']")
    .forEach(option => (option.disabled = true));
}
