import React from "react";
import PropTypes from "prop-types";

class Modal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      open: false
    };
    this.onClose = this.onClose.bind(this);
    this.onConfirm = this.onConfirm.bind(this);
  }

  onClose() {
    this.setState({ open: false });
  }

  onConfirm() {
    this.setState({ open: false });
    this.props.onConfirm();
  }

  render() {
    return (
      <div className="modal">
        <div className="modal__box">
          <p>{this.props.text}</p>
          <button onClick={this.onClose}>Never mind</button>
          <button onClick={this.onConfirm}>OK</button>
        </div>
      </div>
    );
  }
}

Modal.propTypes = {
  text: PropTypes.string.isRequired,
  onConfirm: PropTypes.func
};

export default Modal;
