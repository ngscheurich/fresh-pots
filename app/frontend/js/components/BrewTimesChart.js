import React from "react";
import PropTypes from "prop-types";
import { Line } from "react-chartjs-2";

const BrewTimesChart = ({ chartData }) => {
  const times = [];
  const qtys = [];

  chartData.forEach((datum, index) => {
    times.push(datum[0]);
    qtys.push(datum[1]);
  });

  const data = {
    labels: times,
    datasets: [{ data: qtys }]
  };

  const options = {
    legend: { display: false },
    scales: { yAxes: [{ ticks: { stepSize: 1 } }] }
  };

  return <Line data={data} options={options} />;
};

BrewTimesChart.propTypes = {
  chartData: PropTypes.array.isRequired
};

export default BrewTimesChart;
