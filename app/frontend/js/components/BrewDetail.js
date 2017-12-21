import React from "react";
import PropTypes from "prop-types";

const BrewDetail = ({ text, icon, iconAltText }) => {
  return (
    <div className="brew__detail mh3 mh4-ns flex-1">
      <i className={`nc-icon nc-${icon} v-mid mr2 f4`} />
      <span className="f6 f5-l tracked">{text}</span>
    </div>
  );
};

BrewDetail.propTypes = {
  text: PropTypes.string.isRequired,
  icon: PropTypes.string.isRequired
};

export default BrewDetail;
