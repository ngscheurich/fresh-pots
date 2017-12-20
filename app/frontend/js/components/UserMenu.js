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
          className="pr4 input-reset bn bg-transparent pointer"
          style={{
            background:
              "center right / 30% no-repeat url(/assets/icons/down.svg)"
          }}
          onClick={this.handleToggleMenu}
        >
          <img className="avatar br-100" src={this.props.avatar} />
        </button>
        <div
          className="absolute right-0 bg-red white pa4 dn"
          style={{ top: 40, display: this.state.isOpen ? "block" : "none" }}
        >
          <a href={this.props.editUrl}>Edit profile</a>
        </div>
      </div>
    );
  }
}

UserMenu.propTypes = {
  avatar: PropTypes.string,
  editUrl: PropTypes.string
};

export default UserMenu;
