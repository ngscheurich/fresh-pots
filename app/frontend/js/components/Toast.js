import React, { Component } from "react";
import PropTypes from "prop-types";
import { toast } from "react-toastify";

class Toast extends Component {
  componentDidMount() {
    toast(this.props.text, { type: this.props.type });
  }

  render() {
    console.log("Rendering toast");
    return null;
  }
}

Toast.propTypes = {
  type: PropTypes.string,
  text: PropTypes.string
};

export default Toast;
