import React from "react";
import PropTypes from "prop-types";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import Brew from "./Brew";
import BrewList from "./BrewList";
import * as fetchStates from "../fetchStates";

class RecentBrews extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      brews: [],
      fetchState: fetchStates.NOT_STARTED,
      errorMsg: ""
    };

    this.props.cable.subscriptions.create("BrewsChannel", {
      received: data => this.addBrew(data)
    });

    this.addBrew = this.addBrew.bind(this);
    this.exhaustBrew = this.exhaustBrew.bind(this);
  }

  addBrew(data) {
    const brew = JSON.parse(data);
    this.setState({
      brews: [brew, ...this.state.brews]
    });
  }

  exhaustBrew(id) {
    const brews = this.state.brews;
    this.setState({ brews: brews.filter(brew => brew.id !== id) });
    toast("Pot successfully removed", { type: "success" });
  }

  componentDidMount() {
    axios
      .get("/api/brews/recent", {
        onDownloadProgress: event => {
          this.setState({ fetchState: fetchStates.IN_PROGRESS });
        }
      })
      .then(response => {
        this.setState({
          brews: response.data,
          fetchState: fetchStates.SUCCESS
        });
      })
      .catch(error => {
        this.setState({
          fetchState: fetchStates.FAILURE,
          errorMsg: error.message
        });
      });
  }

  render() {
    return (
      <div>
        <BrewList
          brews={this.state.brews}
          fetchState={this.state.fetchState}
          errorMsg={this.state.errorMsg}
          exhaustBrew={this.exhaustBrew}
        />
      </div>
    );
  }
}

RecentBrews.propTypes = {
  cable: PropTypes.object.isRequired
};

export default RecentBrews;
