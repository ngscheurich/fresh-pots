import React, { Component } from "react";
import PropTypes from "prop-types";

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
      <div className="fr relative">
        <button
          className="input-reset ph0 bn bg-transparent pointer flex items-center dim"
          onClick={this.handleToggleMenu}
        >
          <img className="avatar br-100 mr3" src={this.props.avatar} />
          <i className="nc-icon nc-minimal-down-2 v-mid f6 mr2" />
        </button>
        <div
          className="absolute right-0 dn br2 shadow-2 bg-white pa3"
          style={{
            top: 40,
            display: this.state.isOpen ? "block" : "none",
            minWidth: 150,
            zIndex: 9999
          }}
        >
          <a
            href={this.props.showUrl}
            className="black-80 link dim db mb3 f6 f5-ns ttu tracked"
          >
            View profile
          </a>
          <a
            href={this.props.editUrl}
            className="black-80 link dim db mb3 f6 f5-ns ttu tracked"
          >
            Edit profile
          </a>
          <a
            rel="nofollow"
            data-method="delete"
            href="/users/sign_out"
            className="black-80 link dim db f6 f5-ns ttu tracked"
          >
            Logout
          </a>
        </div>
      </div>
    );
  }
}

UserMenu.propTypes = {
  avatar: PropTypes.string.isRequired,
  showUrl: PropTypes.string.isRequired,
  editUrl: PropTypes.string.isRequired
};

export default UserMenu;
