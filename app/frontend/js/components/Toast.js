import React, { Component } from "react";
import PropTypes from "prop-types";
import { ToastContainer, toast } from "react-toastify";

class Toast extends Component {
  componentDidMount() {
    toast(this.props.text, { type: this.props.type });
  }

  render() {
    return <ToastContainer />;
  }
}

Toast.propTypes = {
  type: PropTypes.string,
  text: PropTypes.string
};

export default Toast;
