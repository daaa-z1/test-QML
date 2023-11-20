import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Item {

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

        LineSeries {
            id: lineSeries1
            name: "press_in"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        LineSeries {
            id: lineSeries2
            name: "press_a"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        LineSeries {
            id: lineSeries3
            name: "press_b"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        LineSeries {
            id: lineSeries4
            name: "flow"
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
            var value1 = mainApp.value["press_in"];
            var value2 = mainApp.value["press_a"];
            var value3 = mainApp.value["press_b"];
            var value4 = mainApp.value["flow"];
            lineSeries1.append(lineSeries1.count, value1);
            lineSeries2.append(lineSeries2.count, value2);
            lineSeries3.append(lineSeries3.count, value3);
            lineSeries4.append(lineSeries4.count, value4);

            // Scroll the x-axis
            if (lineSeries1.count > axisX.max - axisX.min) {
                axisX.min++;
                axisX.max++;
            }
        }
    }
}
