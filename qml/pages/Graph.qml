import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.3

Page {
    visible: true
    width: 640
    height: 480
    title: "Real-time Plot"

    ChartView {
        id: chartView
        anchors.fill: parent
        theme: ChartView.ChartThemeDark
        antialiasing: true

        ValueAxis {
            id: axisX
            min: 0
            max: 10
        }

        ValueAxis {
            id: axisY
            min: 0
            max: 100
        }

        SplineSeries {
            id: splineSeries
            name: "Value"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        Component.onCompleted: {
            // Connect to the valueChanged signal of mainApp
            mainApp.valueChanged.connect(updatePlot);
        }

        function updatePlot() {
            // Append the new value to the series
            var value = mainApp.value["aktual"]; // replace "press_in" with the key you are interested in
            splineSeries.append(splineSeries.count, value);

            // Scroll the x-axis
            if (splineSeries.count > axisX.max - axisX.min) {
                axisX.min++;
                axisX.max++;
            }
        }
    }
}
