import React from "react";
import PropTypes from "prop-types";

class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.tick =
      typeof this.props.tick === "undefined" ? false : this.props.tick;
    this.state = { date: props.date };
  }

  rotation(hand) {
    const date = this.state.date;
    let degrees = 0;
    switch (hand) {
      case "hour":
        degrees = 30 * (date.getHours() % 12) + date.getMinutes() / 2;
        break;
      case "minute":
        degrees = 6 * date.getMinutes();
    }
    return degrees;
  }

  hourStyle() {
    return {
      transform: `rotate(${this.rotation("hour")}deg)`,
      transformOrigin: "bottom center"
    };
  }

  minuteStyle() {
    return {
      transform: `rotate(${this.rotation("minute")}deg)`,
      transformOrigin: "bottom center"
    };
  }

  tick() {
    this.setState(
      Object.assign(...this.state, {
        date: new Date()
      })
    );
  }

  componentDidMount() {
    if (this.tick) {
      this.timerID = setInterval(() => this.tick(), 1000);
    }
  }

  componentWillUnmount() {
    if (typeof this.timerID !== "undefined") {
      clearInterval(this.timerID);
    }
  }

  render() {
    return (
      <svg viewBox="0 0 100 100">
        <circle
          cx="50"
          cy="50"
          r="47"
          fill="transparent"
          stroke={this.props.color}
          strokeWidth="6"
        />
        <rect
          x="47"
          y="20"
          width="6"
          height="30"
          fill={this.props.color}
          style={this.hourStyle()}
        />
        <rect
          x="47"
          y="10"
          width="6"
          height="40"
          fill={this.props.color}
          style={this.minuteStyle()}
        />
        <circle
          className="clock__anchor"
          cx="50"
          cy="50"
          r="3"
          fill={this.props.color}
        />
      </svg>
    );
  }
}

Clock.propTypes = {
  date: PropTypes.object.isRequired,
  color: PropTypes.string.isRequired
};

export default Clock;
