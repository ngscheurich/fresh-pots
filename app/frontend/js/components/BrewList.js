import PropTypes from "prop-types";
import React from "react";
import Brew from "./Brew";

const BrewList = ({ brews }) => {
  return brews.map(brew => <Brew key={brew.id} brew={brew} />);
};

BrewList.propTypes = {
  brews: PropTypes.array.isRequired
};

export default BrewList;
