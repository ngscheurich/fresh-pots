import Turbolinks from "turbolinks";
import React from "react";
import ReactDOM from "react-dom";
import CurrentTime from "./components/CurrentTime";
import RecentBrews from "./components/RecentBrews";

Turbolinks.start();

const App = {
  init() {
    document.addEventListener("turbolinks:load", () => {
      ReactDOM.render(<CurrentTime />, document.querySelector("#current-time"));
      ReactDOM.render(<RecentBrews />, document.querySelector("#brew-list"));
    });
  }
};

module.exports = App;
