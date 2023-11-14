// Graph.qml

import QtQuick 2.15
import QtCharts 2.15

Page {
    id: graphPage

    ChartView {
        id: chartView
        anchors.fill: parent

        LineSeries {
            id: lineSeries
            name: "Graph Data"
            XYPoint { x: 0; y: 0 } // Initial point, you can adjust this based on your data
        }

        ValueAxis {
            id: xAxis
            min: 0
            max: 10 // Adjust the maximum value based on your requirement
            labelFormat: "%.0f"
        }

        ValueAxis {
            id: yAxis
            min: -10 // Adjust the minimum value based on your requirement
            max: 10 // Adjust the maximum value based on your requirement
            labelFormat: "%.1f"
        }

        Component.onCompleted: {
            if (mainApp) {
                mainApp.graphValue.connect(function (values) {
                    // Assuming you have two values in the array for x and y coordinates
                    var xValue = values[0];
                    var yValue = values[1];

                    // Add the new point to the LineSeries
                    lineSeries.append(xValue, yValue);

                    // Scroll the chart view to show the latest points
                    chartView.scroll(xAxis.max, yAxis.max);
                });
            }
        }
    }
}
