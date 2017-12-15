import Turbolinks from "turbolinks";
import React from "react";
import ReactDOM from "react-dom";
import CurrentTime from "./components/CurrentTime";
import RecentBrews from "./components/RecentBrews";
import Toast from "./components/Toast";
import UserMenu from "./components/UserMenu";
import BrewTimesChart from "./components/BrewTimesChart";
import BrewDoughnutChart from "./components/BrewDoughnutChart";
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

function renderBrewTimesChart() {
  const node = document.querySelector("[data-component='brew-times-chart']");

  if (node) {
    const data = JSON.parse(node.dataset.chartData);
    ReactDOM.render(<BrewTimesChart chartData={data} />, node);
  }
}

function renderBrewDoughnutCharts() {
  const nodes = document.querySelectorAll(
    "[data-component='brew-doughnut-chart']"
  );
  console.log(nodes);

  if (nodes.length > 0) {
    nodes.forEach(node => {
      const data = JSON.parse(node.dataset.chartData);
      ReactDOM.render(<BrewDoughnutChart chartData={data} />, node);
    });
  }
}

const App = {
  init() {
    document.addEventListener("turbolinks:load", () => {
      renderComponent(<CurrentTime />, "#current-time");
      renderComponent(<RecentBrews />, "#brew-list");
      renderComponent(<UserMenu />, "#user-menu");
      renderBrewTimesChart();
      renderBrewDoughnutCharts();
      renderToast();
    });
  }
};

module.exports = App;
