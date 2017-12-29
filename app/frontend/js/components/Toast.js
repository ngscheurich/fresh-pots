import React, { Component } from "react";
import PropTypes from "prop-types";
import { toast } from "react-toastify";

class Toast extends Component {
  componentDidMount() {
    toast(this.props.text, {
      type: this.props.type,
      autoClose: this.props.autoClose
    });
  }

  render() {
    return null;
  }
}

Toast.propTypes = {
  type: PropTypes.string,
  text: PropTypes.string,
  autoClose: PropTypes.oneOfType([PropTypes.string, PropTypes.bool])
};

export default Toast;
