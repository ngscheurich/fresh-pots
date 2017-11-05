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
      colorStops: "",
      heatLevel: 1,
      pot: brew.pot.name,
      showModal: false,
      started: started,
      timeAgo: started,
      timezone: timezone,
      variety: brew.variety.name
    };
    this.state.timeAgo = this.calcTimeAgo();
    this.state.heatLevel = this.calcHeatLevel();
    this.state.colorStops = this.generateColorStops();

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

  calcHeatLevel() {
    const maxAge = 180;
    const minutesOld = this.state.started.diff(moment(), "minutes");
    return (maxAge + minutesOld) / maxAge;
  }

  generateColorStops() {
    const heatLevel = this.state.heatLevel;
    const spread = 0.1;
    let stops = [0, heatLevel - spread, heatLevel + spread, 1];
    stops = stops.map((x, i) => {
      const color = i > 1 ? "#1d7db9" : "#fd4757";
      return `${color} ${x * 100}%`;
    });
    return stops.join();
  }

  tick() {
    this.setState(
      Object.assign(...this.state, {
        timeAgo: this.calcTimeAgo(),
        heatLevel: this.calcHeatLevel(),
        colorStops: this.generateColorStops()
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
            className="recent-brew__meter aa white-90 f3 fw3 pa3 bb b--black-20"
            style={{
              background: `linear-gradient(to right, ${this.state.colorStops}`
            }}
          >
            Brewed {this.state.timeAgo.fromNow()}
          </div>

          <div className="recent-brew__details df pv2 ph2 bt b--black-10">
            <div className="recent-brew__meta recent-brew__meta--where f5 fw6 mr3">
              {this.state.pot}
            </div>

            <div className="recent-brew__meta recent-brew__meta--what f5 fw6 mr3">
              {this.state.variety}
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
