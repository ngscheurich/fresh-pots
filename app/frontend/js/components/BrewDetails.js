import React from "react";
import PropTypes from "prop-types";
import BrewDetail from "./BrewDetail";

const BrewDetails = ({ pot, variety, width }) => {
  return (
    <div
      className="flex items-center aa bg-black-80 white-80 pv2 pv0-ns"
      style={{ width: `${width}%`, borderRadius: "0 0 0.5rem 0" }}
    >
      <BrewDetail text={pot} icon="pin" iconAltText="Map pin icon" />
      <BrewDetail text={variety} icon="beans" iconAltText="Coffee beans icon" />
    </div>
  );
};

BrewDetails.propTypes = {
  pot: PropTypes.string.isRequired,
  variety: PropTypes.string.isRequired,
  width: PropTypes.string.isRequired
};

export default BrewDetails;