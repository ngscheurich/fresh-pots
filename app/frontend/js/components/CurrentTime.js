import React from "react";
import moment from "moment";
import "moment-timezone";

export default class CurrentTime extends React.Component {
  constructor(props) {
    super(props);
    let timezone = moment.tz.guess();
    this.state = {
      now: this.currentTimeFormatted(timezone),
      timezone
    };
  }

  currentTimeFormatted(timezone) {
    return moment()
      .tz(timezone)
      .format("h:mm:ss A");
  }

  componentDidMount() {
    this.timerID = setInterval(() => this.tick(), 1000);
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  tick() {
    this.setState(
      Object.assign(...this.state, {
        now: this.currentTimeFormatted(this.state.timezone)
      })
    );
  }

  render() {
    return this.state.now;
  }
}
