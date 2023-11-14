import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Window {
    visible: true
    width: 600
    height: 400

    ChartView {
        id: lineChart
        anchors.fill: parent

        // Set the chart title
        title: "Realtime Line Chart"

        // Add a series to the chart
        LineSeries {
            name: "Data"
            data: [
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10
            ]
        }

        // Update the chart data every second
        Timer {
            running: true
            repeat: true
            interval: 1000
            onTriggered: {
                lineChart.series.data.append(Math.random())
            }
        }
    }
}