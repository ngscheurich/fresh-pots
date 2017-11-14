import React from "react";
import PropTypes from "prop-types";

const BrewDetail = ({ text, icon, iconAltText }) => {
  return (
    <div className="mh3 mh4-ns f5 flex-1">
      <img
        className="v-mid mr1 o-50"
        src={`/assets/icons/${icon}.svg`}
        alt={iconAltText}
        style={{ height: "24px" }}
      />
      {text}
    </div>
  );
};

BrewDetail.propTypes = {
  text: PropTypes.string.isRequired,
  icon: PropTypes.string.isRequired,
  iconAltText: PropTypes.string.isRequired
};

export default BrewDetail;