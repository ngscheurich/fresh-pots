import React from "react";
import PropTypes from "prop-types";
import { ToastContainer, toast } from "react-toastify";
import LoadingIndicator from "react-loading-indicator";
import Brew from "./Brew";
import * as fetchStates from "../fetchStates";

const BrewList = ({ brews, fetchState, errorMsg, exhaustBrew }) => {
  switch (fetchState) {
    case fetchStates.NOT_STARTED || fetchStates.IN_PROGRESS:
      return loadingIndicator();

    case fetchStates.SUCCESS:
      return renderBrews(brews, exhaustBrew);

    case fetchStates.FAILURE:
      return renderErrorMsg(errorMsg);

    default:
      return null;
  }
};

BrewList.propTypes = {
  brews: PropTypes.array.isRequired,
  fetchState: PropTypes.string.isRequired,
  errorMsg: PropTypes.string.isRequired,
  exhaustBrew: PropTypes.func.isRequired
};

const loadingIndicator = () => {
  return (
    <div className="center" style={{ height: 36, width: 36 }}>
      <LoadingIndicator
        segmentLength={6}
        segmentWidth={3}
        segments={6}
        spacing={4}
      />
    </div>
  );
};

const renderBrews = (brews, exhaustBrew) => {
  if (brews.length === 0) {
    return renderNoBrewsMsg();
  } else {
    return brews.map(brew => (
      <Brew key={brew.id} brew={brew} exhaustBrew={exhaustBrew} />
    ));
  }
};

const renderNoBrewsMsg = () => {
  return (
    <p className="f3 tc">
      <span className="emoji mr2">😱</span>
      There’s no coffee! You should go&nbsp;
      <a className="link dim black-60" href="/brews/new">
        brew some
      </a>.
    </p>
  );
};

const renderErrorMsg = msg => {
  return (
    <p className="f3 tc">
      <span className="emoji mr2">⚠️</span>
      {msg}
    </p>
  );
};

export default BrewList;
