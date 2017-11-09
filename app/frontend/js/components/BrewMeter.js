import React from "react";
import PropTypes from "prop-types";

const BrewMeter = ({ colorStops, timeAgo, width }) => {
  return (
    <div
      className="flex items-center"
      style={{
        background: `linear-gradient(to right, ${colorStops}`,
        width: `${width}%`,
        borderRadius: "0 .5rem 0 0"
      }}
    >
      <div className="aa white-90 f3 fw4 pa3 ph4-ns pv0-ns tshadow">
        Brewed {timeAgo}
      </div>
    </div>
  );
};

BrewMeter.propTypes = {
  colorStops: PropTypes.string.isRequired,
  timeAgo: PropTypes.string.isRequired,
  width: PropTypes.string.isRequired
};

export default BrewMeter;
