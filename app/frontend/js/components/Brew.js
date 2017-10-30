import React from "react";
import PropTypes from "prop-types";
import moment from "moment";
import "moment-timezone";

class Brew extends React.Component {
  constructor(props) {
    super(props);
    const brew = props.brew;
    const timezone = moment.tz.guess();
    const started = moment.tz(brew.created_at, timezone);

    this.state = {
      pot: brew.pot.name,
      type: brew.coffee_type.name,
      timezone: timezone,
      started: started,
      timeAgo: started,
      style: {
        opacity: 1,
        colorStops: ""
      }
    };

    this.state.timeAgo = this.calcTimeAgo();
    this.state.style.opacity = this.calcOpacity();
    this.state.style.colorStops = this.generateColorStops();
  }

  calcTimeAgo() {
    return moment(this.state.started).tz(this.state.timezone);
  }

  calcOpacity() {
    const maxAge = 180;
    const minutesOld = this.state.started.diff(moment(), "minutes");
    return (maxAge + minutesOld) / maxAge;
  }

  generateColorStops() {
    const opacity = this.state.style.opacity;
    const spread = 0.1;
    let stops = [0, opacity - spread, opacity + spread, 1];
    stops = stops.map((x, i) => {
      const color = i > 1 ? "#03639F" : "#F5515F";
      return `${color} ${x * 100}%`;
    });
    return stops.join();
  }

  boundedOpacity(opacity) {
    const minOpacity = 0.35;
    opacity = opacity > 1 ? 1 : opacity;
    return opacity < minOpacity ? minOpacity : opacity;
  }

  tick() {
    this.setState(
      Object.assign(...this.state, {
        timeAgo: this.calcTimeAgo(),
        style: {
          opacity: this.calcOpacity(),
          gradient: this.generateColorStops()
        }
      })
    );
  }

  componentDidMount() {
    this.timerID = setInterval(() => this.tick(), 1000);
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  render() {
    return (
      <div
        className="recent-brew df mb4 br2 box bg-white-10"
        style={{ opacity: this.boundedOpacity(this.state.style.opacity) }}
      >
        <div className="pv3 ph4 br b--black-20 df bg-white-05">
          <div className="recent-brew__when f4 fw3 as-center">
            {moment(this.state.started).format("h:mm a")}
          </div>
        </div>
        <div className="recent-brew__info fx-1">
          <div
            className="recent-brew__meter f4 fw3 pa4 bb b--black-50"
            style={{
              background: `linear-gradient(to right, ${this.state.style
                .colorStops}`
            }}
          >
            Brewed {this.state.timeAgo.fromNow()}
          </div>

          <div className="recent-brew__details df pv2 ph4 bt b--black-10">
            <div className="recent-brew__meta recent-brew__meta--where fx-1 f6">
              {this.state.pot}
            </div>

            <div className="recent-brew__meta recent-brew__meta--what fx-1 f6">
              {this.state.type}
            </div>

            <div className="fx-1">
              <a
                className="recent-brew__button f6 bg-white-10 fr ph3 br2 link white dim"
                href="#"
              >
                Kill pot
              </a>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

Brew.propTypes = {
  brew: PropTypes.object.isRequired
};

export default Brew;
