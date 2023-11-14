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
            name: "LineSeries"
            XYPoint { x: 0; y: 0 }
            XYPoint { x: 1.1; y: 2.1 }
            XYPoint { x: 1.9; y: 3.3 }
            XYPoint { x: 2.1; y: 2.1 }
            XYPoint { x: 2.9; y: 4.9 }
            XYPoint { x: 3.4; y: 3.0 }
            XYPoint { x: 4.1; y: 3.3 }
        }

        // Update the chart data every second
        // Timer {
        //     running: true
        //     repeat: true
        //     interval: 1000
        //     onTriggered: {
        //         lineChart.series.data.append(Math.random())
        //     }
        // }
    }
}