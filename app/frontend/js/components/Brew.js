import React from "react";
import PropTypes from "prop-types";
import moment from "moment";
import "moment-timezone";

class Brew extends React.Component {
  constructor(props) {
    super(props);
    let brew = props.brew;
    let timezone = moment.tz.guess();
    this.state = {
      pot: brew.pot.name,
      type: brew.coffee_type.name,
      started: moment.tz(brew.created_at, timezone),
      timeAgo: moment.tz(brew.created_at, timezone).fromNow(),
      timezone
    };
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
        timeAgo: moment(this.state.started)
          .tz(this.state.timezone)
          .fromNow()
      })
    );
  }

  render() {
    return (
      <div className="recent-brew df mb4 br2 box bg-white-10">
        <div className="recent-brew__when pv2 ph4 br b--black-20 df bg-white-05">
          <div className="f4 fw3 as-end">
            {moment(this.state.started).format("h:mm a")}
          </div>
        </div>
        <div className="recent-brew__info fx-1">
          <div className="recent-brew__meter f4 fw3 br-pill pa2 ma4 bb b--black-50">
            Brewed {this.state.timeAgo}
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
