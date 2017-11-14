import PropTypes from "prop-types";
import React from "react";
import Brew from "./Brew";

const BrewList = ({ brews }) => {
  if (brews.length === 0) {
    return (
      <p className="f3 tc">
        <span className="emoji">😱</span>
        There’s no coffee! You should go&nbsp;
        <a className="link dim black-60" href="/brews/new">
          brew some
        </a>.
      </p>
    );
  } else {
    return brews.map(brew => <Brew key={brew.id} brew={brew} />);
  }
};

BrewList.propTypes = {
  brews: PropTypes.array.isRequired
};

export default BrewList;
