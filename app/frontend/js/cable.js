import React from "react";
import ActionCable from "actioncable";
import { component } from "./render";
import RecentBrews from "./components/RecentBrews";

export function brews() {
  if (location.pathname === "/dashboard") {
    const cable = ActionCable.createConsumer(`ws://${location.host}/cable`);
    component(<RecentBrews cable={cable} />, "brew-list");
  }
}
