import React from "react";
import PropTypes from "prop-types";
import { Doughnut } from "react-chartjs-2";

const BrewDoughnutChart = ({ chartData }) => {
  const varieties = [];
  const qtys = [];

  Object.entries(chartData).forEach(datum => {
    varieties.push(datum[0]);
    qtys.push(datum[1]);
  });

  const data = {
    labels: varieties,
    datasets: [{ data: qtys }]
  };

  const options = {
    legend: { display: false }
  };

  return <Doughnut data={data} options={options} />;
};

BrewDoughnutChart.propTypes = {
  chartData: PropTypes.object.isRequired
};

export default BrewDoughnutChart;
