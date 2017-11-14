import Turbolinks from "turbolinks";
import React from "react";
import ReactDOM from "react-dom";
import CurrentTime from "./components/CurrentTime";
import RecentBrews from "./components/RecentBrews";
import Toast from "./components/Toast";
import UserMenu from "./components/UserMenu";
import "rails-ujs";

Turbolinks.start();

function renderComponent(component, selector) {
  const node = document.querySelector(selector);

  if (node) {
    ReactDOM.render(component, node);
  }
}

function renderToast() {
  const node = document.querySelector("#toast");

  if (node) {
    const type = node.dataset.type;
    const text = node.dataset.text;
    ReactDOM.render(<Toast type={type} text={text} />, node);
  }
}

const App = {
  init() {
    document.addEventListener("turbolinks:load", () => {
      renderComponent(<CurrentTime />, "#current-time");
      renderComponent(<RecentBrews />, "#brew-list");
      renderComponent(<UserMenu />, "#user-menu");
      renderToast();
    });
  }
};

module.exports = App;
