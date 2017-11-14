import BrewList from "./BrewList";
import React from "react";
import axios from "axios";

export default class RecentBrews extends React.Component {
  constructor(props) {
    super(props);
    this.state = { brews: [] };
  }

  componentDidMount() {
    axios
      .get("/api/brews/recent")
      .then(response => this.setState({ brews: response.data }))
      .catch(error => console.log(error));
  }

  render() {
    return <BrewList brews={this.state.brews} />;
  }
}
