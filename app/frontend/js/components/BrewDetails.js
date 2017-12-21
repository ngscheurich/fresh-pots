import React from "react";
import PropTypes from "prop-types";
import BrewDetail from "./BrewDetail";

const BrewDetails = ({ pot, variety, width }) => {
  return (
    <div
      className="brew__details flex items-center aa bg-black-80 white-90 ttu pv2 pv0-ns f6"
      style={{ width: `${width}%`, borderRadius: "0 0 0.5rem 0" }}
    >
      <BrewDetail text={pot} icon="treasure-map-21" />
      <BrewDetail text={variety} icon="drop-2" />
    </div>
  );
};

BrewDetails.propTypes = {
  pot: PropTypes.string.isRequired,
  variety: PropTypes.string.isRequired,
  width: PropTypes.string.isRequired
};

export default BrewDetails;
