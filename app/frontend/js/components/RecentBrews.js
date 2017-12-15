import React from "react";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import BrewList from "./BrewList";
import * as fetchStates from "../fetchStates";

export default class RecentBrews extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      brews: [],
      fetchState: fetchStates.NOT_STARTED,
      errorMsg: ""
    };

    this.exhaustBrew = this.exhaustBrew.bind(this);
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

  exhaustBrew(id) {
    const brews = this.state.brews;
    this.setState({ brews: brews.filter(brew => brew.id !== id) });
    toast("Pot successfully removed", { type: "success" });
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
        <ToastContainer />
      </div>
    );
  }
}
