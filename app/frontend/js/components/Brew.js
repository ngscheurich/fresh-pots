import React from "react";
import PropTypes from "prop-types";
import ReactModal from "react-modal";
import moment from "moment";
import "moment-timezone";
import Clock from "./Clock";

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
    this.handleOpenModal = this.handleOpenModal.bind(this);
    this.handleCloseModal = this.handleCloseModal.bind(this);
  }

  handleOpenModal() {
    this.setState(Object.assign(...this.state, { showModal: true }));
  }

  handleCloseModal() {
    this.setState(Object.assign(...this.state, { showModal: false }));
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
      <div className="recent-brew df mb4 br3 box bg-white animated fadeIn">
        <div className="pv3 ph4 br b--black-20 df">
          <div className="recent-brew__when f4 fw3 as-center">
            <div className="recent-brew__clock center mb3">
              <Clock date={new Date(this.props.brew.created_at)} color="#444" />
            </div>
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

            <div className="recent-brew__meta recent-brew__meta--what f5 fw6 mr3">
              {this.props.brew.user.email}
            </div>
          </div>
        </div>

        <ReactModal
          isOpen={this.state.showModal}
          contentLable="My my my…"
          style={{
            content: {
              color: "#222",
              top: "50%",
              right: "auto",
              bottom: "auto",
              left: "50%",
              transform: "translate(-50%, -50%)"
            },
            overlay: { backgroundColor: "rgba(0, 0, 0, 0.5)" }
          }}
        >
          <p>
            <strong>Are you sure you want to kill this pot?</strong>
          </p>
          <p>This will let everyone know this pot is now empty.</p>
          <button onClick={this.handleCloseModal}>
            Yes, {this.props.brew.id}
          </button>
        </ReactModal>
      </div>
    );
  }
}

Brew.propTypes = {
  brew: PropTypes.object.isRequired
};

export default Brew;
