import React from "react";
import PropTypes from "prop-types";
import Clock from "./Clock";

const BrewClock = ({ date, width }) => {
  return (
    <div className="brew__clock dn db-ns pv2" style={{ width: `${width}%` }}>
      <div className="center mt2" style={{ width: "45px", height: "45px" }}>
        <Clock
          date={date}
          color="#555"
          hourHandLength={0.55}
          minuteHandLength={0.8}
          hourHandWidth={6}
          minuteHandWidth={5}
          size={50}
          strokeWidth={8}
        />
      </div>
    </div>
  );
};

BrewClock.propTypes = {
  date: PropTypes.object.isRequired,
  width: PropTypes.string.isRequired
};

export default BrewClock;
