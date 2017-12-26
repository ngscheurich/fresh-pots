import Turbolinks from "turbolinks";
import React from "react";
import ReactDOM from "react-dom";
import CurrentTime from "./components/CurrentTime";
import RecentBrews from "./components/RecentBrews";
import Toast from "./components/Toast";
import UserMenu from "./components/UserMenu";
import BrewTimesChart from "./components/BrewTimesChart";
import BrewDoughnutChart from "./components/BrewDoughnutChart";
import ActionCable from "actioncable";
import "rails-ujs";

Turbolinks.start();

function DOMElement(name) {
  return document.querySelector(`[data-component='${name}']`);
}

function DOMElements(name) {
  return document.querySelectorAll(`[data-component='${name}']`);
}

function renderComponent(component, name) {
  const node = DOMElement(name);
  if (node) ReactDOM.render(component, node);
}

function renderToast() {
  const node = DOMElement("toast");

  if (node) {
    const type = node.dataset.type;
    const text = node.dataset.text;
    ReactDOM.render(<Toast type={type} text={text} />, node);
  }
}

function renderBrewTimesChart() {
  const node = DOMElement("brew-times-chart");

  if (node) {
    const data = JSON.parse(node.dataset.chartData);
    ReactDOM.render(<BrewTimesChart chartData={data} />, node);
  }
}

function renderBrewDoughnutCharts() {
  const nodes = DOMElements("brew-doughnut-chart");

  if (nodes.length > 0) {
    nodes.forEach(node => {
      const data = JSON.parse(node.dataset.chartData);
      ReactDOM.render(<BrewDoughnutChart chartData={data} />, node);
    });
  }
}

function renderUserMenu() {
  const node = DOMElement("user-menu");

  if (node) {
    const data = node.dataset;
    ReactDOM.render(
      <UserMenu
        avatar={data.avatar}
        showUrl={data.showUrl}
        editUrl={data.editUrl}
      />,
      node
    );
  }
}

function addSelectDefault(selector, text) {
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

function disablePlaceholderOptions() {
  document
    .querySelectorAll("option[value='']")
    .forEach(option => (option.disabled = true));
}

function formShouldUseXHR(selector, loadURL, errorURL) {
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
      XHR.send(FD);
    });
  }
}

const App = {
  init() {
    document.addEventListener("turbolinks:load", () => {
      renderComponent(<CurrentTime />, "current-time");
      renderUserMenu();
      renderBrewTimesChart();
      renderBrewDoughnutCharts();
      renderToast();
      disablePlaceholderOptions();
      formShouldUseXHR("#new_brew", "/dashboard?brew_created", null);
      formShouldUseXHR("#new_user", "/dashboard?logged_in", null);

      if (location.pathname === "/dashboard") {
        const cable = ActionCable.createConsumer("ws://localhost:3000/cable");
        renderComponent(<RecentBrews cable={cable} />, "brew-list");
      }
    });
  }
};

module.exports = App;
