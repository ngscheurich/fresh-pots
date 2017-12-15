import React, { Component } from "react";
import Radium from "radium";

class UserMenu extends Component {
  constructor(props) {
    super(props);
    this.state = { isOpen: false };
    this.handleToggleMenu = this.handleToggleMenu.bind(this);
  }

  handleToggleMenu() {
    this.setState({
      isOpen: !this.state.isOpen
    });
  }

  render() {
    return (
      <div>
        <button
          className="pointer bn input-reset bg-transparent dim pa0"
          onClick={this.handleToggleMenu}
        >
          <img
            className="v-mid o-80 burger"
            src="/assets/icons/burger.svg"
            alt="Menu icon"
          />
        </button>

        <div
          className="fixed z-2 right-0 top-0 h-100 fw3 w-33-ns"
          style={[
            styles.base,
            this.state.isOpen ? styles.expanded : styles.isClosed
          ]}
        >
          <a
            className="db ma4 link dim white-80 ttu f4"
            href="/users/sign_out"
            rel="nofollow"
            data-method="delete"
          >
            <img
              className="v-mid mr2 o-50"
              src="/assets/icons/leave.svg"
              alt=""
              style={{ height: "36px" }}
            />
            Sign out
          </a>

          <a className="db ma4 link dim white-80 ttu f4" href="#">
            <img
              className="v-mid mr2 o-50"
              src="/assets/icons/edit.svg"
              alt="Sign out icon"
              style={{ height: "36px" }}
            />
            Edit your profile
          </a>

          <div
            className="fixed left-0 top-0"
            style={{ width: "100vw", height: "100vh", zIndex: -1 }}
            onClick={this.handleToggleMenu}
          />
        </div>
      </div>
    );
  }
}

const styles = {
  base: {
    backgroundColor: "#222222",
    boxShadow: "0 0 30px rgba(0, 0, 0, 0.4)",
    transition: "all 0.2s ease-in-out"
  },
  isOpen: {
    transform: "translateX(0)"
  },
  isClosed: {
    transform: "translateX(100%)"
  }
};

export default Radium(UserMenu);
