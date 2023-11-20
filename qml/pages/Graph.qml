import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage

    ChartView {
        id: chartView
        anchors.fill: parent
        legend.visible: false

        LineSeries {
            id: lineSeries
        }

        ValueAxis {
            id: xAxis
            min: 0
            max: 100
        }

        ValueAxis {
            id: yAxis
            min: 0
            max: 100
        }

        Component.onCompleted: {
            // Set up initial series
            chartView.series.append(lineSeries);
        }

        // Connect to the signal from readValues in MainApp
        Connections {
            target: mainApp
            function onValueChanged() {
                // Add the new data point to the series
                lineSeries.append(mainApp.value[mainApp.keys[]]);
                // Keep only the last N data points to prevent the chart from growing indefinitely
                if (lineSeries.count() > 100) {
                    lineSeries.remove(0, 1);
                }
                // Adjust the axis range dynamically if needed
                xAxis.max = lineSeries.count();
                yAxis.max = Math.max.apply(null, lineSeries.points);
            }
        }
    }
}
