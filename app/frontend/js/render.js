import React from "react";
import ReactDOM from "react-dom";
import Toast from "./components/Toast";
import UserMenu from "./components/UserMenu";
import MobileMenu from "./components/MobileMenu";
import BrewTimesChart from "./components/BrewTimesChart";
import BrewDoughnutChart from "./components/BrewDoughnutChart";
import * as Selectors from "./selectors";

export function component(component, name) {
  const node = Selectors.component(name);
  if (node) ReactDOM.render(component, node);
}

export function toasts() {
  const nodes = Selectors.components("toast");

  nodes.forEach(node => {
    const type = node.dataset.type;
    const text = node.dataset.text;
    let autoClose;
    const dataValue = node.dataset.autoClose;
    switch (true) {
      case dataValue === "true":
        autoClose = true;
        break;
      case dataValue === "false":
        autoClose = false;
        break;
      case !isNaN(dataValue):
        autoClose = dataValue;
        break;
      default:
        autoClose = 5000;
        break;
    }
    console.log(autoClose);

    ReactDOM.render(
      <Toast type={type} text={text} autoClose={autoClose} />,
      node
    );
  });
}

export function brewTimesChart() {
  const node = Selectors.component("brew-times-chart");

  if (node) {
    const data = JSON.parse(node.dataset.chartData);
    ReactDOM.render(<BrewTimesChart chartData={data} />, node);
  }
}

export function brewDoughnutCharts() {
  const nodes = Selectors.components("brew-doughnut-chart");

  nodes.forEach(node => {
    const data = JSON.parse(node.dataset.chartData);
    ReactDOM.render(<BrewDoughnutChart chartData={data} />, node);
  });
}

export function userMenu() {
  const node = Selectors.component("user-menu");

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

export function mobileMenu() {
  const node = Selectors.component("mobile-menu");

  if (node) {
    const data = node.dataset;
    ReactDOM.render(
      <MobileMenu
        avatar={data.avatar}
        showUrl={data.showUrl}
        editUrl={data.editUrl}
      />,
      node
    );
  }
}
