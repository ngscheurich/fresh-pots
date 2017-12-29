import Turbolinks from "turbolinks";
import React from "react";
import ReactDOM from "react-dom";
import CurrentTime from "./components/CurrentTime";
import RecentBrews from "./components/RecentBrews";
import ActionCable from "actioncable";
import * as Render from "./render";
import * as Forms from "./forms";
import "rails-ujs";
import { ToastContainer, toast } from "react-toastify";

Turbolinks.start();

console.log("001");

const App = {
  init() {
    document.addEventListener("turbolinks:load", () => {
      Render.component(<ToastContainer />, "toast-container");
      Render.component(<CurrentTime />, "current-time");
      Render.userMenu();
      Render.mobileMenu();
      Render.brewTimesChart();
      Render.brewDoughnutCharts();
      Render.toasts();

      Forms.disablePlaceholderOptions();
      Forms.useXHR("#new_brew", "/dashboard?brew_logged=true", null);
      Forms.useXHR("#new_user[action='/users']", "/home?signed_up=true", null);
      Forms.useXHR("#new_user[action='/users/sign_in']", "/dashboard", null);

      if (location.pathname === "/dashboard") {
        const cable = ActionCable.createConsumer("ws://localhost:3000/cable");
        Render.component(<RecentBrews cable={cable} />, "brew-list");
      }
    });
  }
};

module.exports = App;
