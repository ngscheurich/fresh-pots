import React, { Component } from "react";
import PropTypes from "prop-types";

class Clock extends Component {
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
    const size = this.props.size;
    const strokeWidth = this.props.strokeWidth;
    const hourHandWidth = this.props.hourHandWidth;
    const hourHandLength = this.props.hourHandLength;
    const minuteHandWidth = this.props.minuteHandWidth;
    const minuteHandLength = this.props.minuteHandLength;

    return (
      <svg viewBox={`0 0 ${size * 2} ${size * 2}`}>
        <circle
          cx={size}
          cy={size}
          r={size - strokeWidth / 2}
          fill="transparent"
          stroke={this.props.color}
          strokeWidth={strokeWidth}
        />
        <rect
          x={size - hourHandWidth / 2}
          y={size - size * hourHandLength}
          width={hourHandWidth}
          height={size * hourHandLength}
          fill={this.props.color}
          style={this.hourStyle()}
        />
        <rect
          x={size - minuteHandWidth / 2}
          y={size - size * minuteHandLength}
          width={minuteHandWidth}
          height={size * minuteHandLength}
          fill={this.props.color}
          style={this.minuteStyle()}
        />
        <circle
          className="clock__anchor"
          cx={size}
          cy={size}
          r={
            minuteHandWidth > hourHandWidth
              ? minuteHandWidth * 0.375
              : hourHandWidth * 0.375
          }
          fill={this.props.color}
        />
      </svg>
    );
  }
}

Clock.propTypes = {
  color: PropTypes.string.isRequired,
  date: PropTypes.object.isRequired,
  hourHandLength: PropTypes.number.isRequired,
  hourHandWidth: PropTypes.number.isRequired,
  minuteHandWidth: PropTypes.number.isRequired,
  minuteHandLength: PropTypes.number.isRequired,
  size: PropTypes.number.isRequired,
  strokeWidth: PropTypes.number.isRequired
};

export default Clock;
