import React from "react";
import PropTypes from "prop-types";

const BrewStarted = ({ time, width }) => {
  return (
    <div
      className="brew__started dn db-ns pv2 f5 f4-ns tc ttu"
      style={{ width: `${width}%` }}
    >
      <div className="mv1">{time}</div>
    </div>
  );
};

BrewStarted.propTypes = {
  time: PropTypes.string.isRequired,
  width: PropTypes.string.isRequired
};

export default BrewStarted;
