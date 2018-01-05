import React, { Component } from "react";
import PropTypes from "prop-types";
import Turblinks from "turbolinks";
import Modal from "react-modal";

const modalStyles = {
  content: {
    top: "50%",
    right: "auto",
    bottom: "auto",
    left: "50%",
    transform: "translate(-50%, -50%)",
    boxShadow: "0 20px 60px rgba(0, 0, 0, 0.7)",
    width: "60%",
    padding: "2em"
  },
  overlay: { backgroundColor: "rgba(0, 0, 0, 0.5)" }
};

class MobileMenu extends Component {
  constructor(props) {
    super(props);

    this.state = {
      showModal: false
    };

    this.handleOpenModal = this.handleOpenModal.bind(this);
    this.handleCloseModal = this.handleCloseModal.bind(this);
    this.handleLogout = this.handleLogout.bind(this);
  }

  handleOpenModal() {
    this.setState({ showModal: true });
    this.appContainer.classList.add("is-frosted");
  }

  handleCloseModal() {
    this.setState({ showModal: false });
    this.appContainer.classList.remove("is-frosted");
  }

  handleLogout(event) {
    event.preventDefault();

    const xhr = new XMLHttpRequest();

    xhr.open("DELETE", "/api/sign_out");
    xhr.send();

    Turbolinks.start();
    Turblinks.visit("/");
  }

  componentDidMount() {
    this.appContainer = document.querySelector("#app");
    Modal.setAppElement = this.appContainer;
  }

  render() {
    return (
      <div>
        <button
          className="input-reset ph0 bn bg-black br-100 fixed flex items-center justify-center tc"
          style={{
            right: 30,
            bottom: 30,
            width: 60,
            height: 60,
            boxShadow: "0 3px 20px rgba(0, 0, 0, 0.7)"
          }}
          onClick={this.handleOpenModal}
        >
          <i className="nc-icon nc-menu-dots-2 v-mid f4 white" />
        </button>

        <Modal
          isOpen={this.state.showModal}
          shouldCloseOnOverlayClick={true}
          onRequestClose={() => this.handleCloseModal()}
          appElement={this.appContainer}
          style={modalStyles}
        >
          <div className="tc">
            <img
              className="avatar br-100 mb4 db center"
              style={{ width: 80, height: 80 }}
              src={this.props.avatar}
            />

            <a
              href="/brews/new"
              className="black-80 link dim db mb3 f5 fw7 ttu tracked"
            >
              Start a brew
            </a>

            <a
              href={this.props.showUrl}
              className="black-80 link dim db mb3 f5 ttu tracked"
            >
              View profile
            </a>

            <a
              href={this.props.editUrl}
              className="black-80 link dim db mb3 f5 ttu tracked"
            >
              Edit profile
            </a>

            <a
              onClick={this.handleLogout}
              className="black-80 link dim db f5 ttu tracked"
            >
              Logout
            </a>
          </div>
        </Modal>
      </div>
    );
  }
}

MobileMenu.propTypes = {
  avatar: PropTypes.string.isRequired,
  showUrl: PropTypes.string.isRequired,
  editUrl: PropTypes.string.isRequired
};

export default MobileMenu;
