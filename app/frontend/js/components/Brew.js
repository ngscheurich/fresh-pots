import React from "react";
import PropTypes from "prop-types";
import Modal from "react-modal";
import moment from "moment";
import "moment-timezone";
import BrewClock from "./BrewClock";
import BrewMeter from "./BrewMeter";
import BrewStarted from "./BrewStarted";
import BrewDetails from "./BrewDetails";

const modalStyle = {
  content: {
    top: "30%",
    right: "auto",
    bottom: "auto",
    left: "50%",
    transform: "translate(-50%, -30%)"
  },
  overlay: { backgroundColor: "rgba(0, 0, 0, 0.7)" }
};

class Brew extends React.Component {
  constructor(props) {
    super(props);
    this.timezone = moment.tz.guess();
    this.started = moment.tz(props.brew.created_at, this.timezone);

    this.state = {
      colorStops: "",
      heatLevel: 1,
      showMenu: false,
      showModal: false,
      timeAgo: this.started
    };
    this.state.timeAgo = this.calcTimeAgo();
    this.state.heatLevel = this.calcHeatLevel();
    this.state.colorStops = this.generateColorStops();

    this.handleOpenModal = this.handleOpenModal.bind(this);
    this.handleCloseModal = this.handleCloseModal.bind(this);
    this.handleToggleMenu = this.handleToggleMenu.bind(this);
  }

  handleOpenModal() {
    const newMenuState = this.state.showMenu ? false : true;
    this.setState({ showModal: true, showMenu: newMenuState });
  }

  handleCloseModal() {
    this.setState({ showModal: false });
  }

  calcTimeAgo() {
    return moment(this.started).tz(this.timezone);
  }

  calcHeatLevel() {
    const maxAge = 180;
    const minutesOld = this.started.diff(moment(), "minutes");
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
    this.setState({
      timeAgo: this.calcTimeAgo(),
      heatLevel: this.calcHeatLevel(),
      colorStops: this.generateColorStops()
    });
  }

  componentDidMount() {
    this.timerID = setInterval(() => this.tick(), 1000);
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  handleToggleMenu() {
    this.setState({ showMenu: !this.state.showMenu });
  }

  render() {
    const { brew } = this.props;

    return (
      <div>
        <div
          className="mb3 mb4-ns br3 box bg-white animated fadeIn relative overflow-visible"
          key={brew.id}
        >
          <button
            className="pointer bn input-reset absolute"
            style={{
              background: "center / 22px no-repeat url(/assets/icons/more.svg)",
              height: "45px",
              width: "35px",
              top: 5,
              right: 5,
              textIndent: -9999
            }}
            onClick={this.handleToggleMenu}
          >
            Actions
          </button>

          <div
            className="absolute right-1 top-1 shadow-2 bg-white br2 z-2"
            style={{ display: this.state.showMenu ? "block" : "none" }}
          >
            <button
              className="pointer bn-reset bg-transparent bn db black-80 lh-solid pa3 f5 z-1"
              onClick={this.handleOpenModal}
            >
              <span className="mr2">💀</span>Kill pot
            </button>
            <div
              className="fixed left-0 top-0"
              style={{ width: "100vw", height: "100vh", zIndex: -1 }}
              onClick={this.handleToggleMenu}
            />
          </div>

          <div className="flex">
            <BrewClock date={new Date(brew.created_at)} width="18" />

            <BrewMeter
              colorStops={this.state.colorStops}
              timeAgo={this.state.timeAgo.fromNow()}
              width="82"
            />
          </div>

          <div className="flex">
            <BrewStarted
              time={moment(this.state.started).format("h:mm a")}
              width="18"
            />

            <BrewDetails
              pot={brew.pot.name}
              variety={brew.variety.name}
              width="82"
            />
          </div>
        </div>
        <Modal isOpen={this.state.showModal} style={modalStyle}>
          <h1>Well, hello there!</h1>
          <button onClick={this.handleCloseModal}>Go away</button>
        </Modal>
      </div>
    );
  }
}

Brew.propTypes = {
  brew: PropTypes.object.isRequired
};

export default Brew;
