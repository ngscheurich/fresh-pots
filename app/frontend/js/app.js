import Turbolinks from "turbolinks";
import React from "react";
import ReactDOM from "react-dom";
import CurrentTime from "./components/CurrentTime";
import * as Render from "./render";
import * as Forms from "./forms";
import * as Cable from "./cable";
import * as Utils from "./utils.js";
import { ToastContainer, toast } from "react-toastify";

import "rails-ujs";

Turbolinks.start();

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

      Forms.useXHR("#new_user[action='/users']", "/home?confirm=true");
      Forms.useXHR("#new_user[action='/users/sign_in']", "/dashboard");
      Forms.useXHR("#new_brew", "/dashboard");
      Forms.useXHR(".edit_user", "/me");

      Cable.brews();

      Utils.clearModal();
    });
  }
};

module.exports = App;
