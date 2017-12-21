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

const cable = ActionCable.createConsumer("ws://localhost:3000/cable");

const App = {
  init() {
    document.addEventListener("turbolinks:load", () => {
      renderComponent(<CurrentTime />, "current-time");
      renderComponent(<RecentBrews cable={cable} />, "brew-list");
      renderUserMenu();
      renderBrewTimesChart();
      renderBrewDoughnutCharts();
      renderToast();
    });
  }
};

module.exports = App;
