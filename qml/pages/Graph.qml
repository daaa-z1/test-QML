import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Item {
    property var position_keys: ['curr_v', 'aktual']
    property var flow_keys: ['press_in', 'flow']
    property var leakage_keys: ['press_in', 'press_a', 'press_b', 'flow']

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
            name: "Position Test"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        LineSeries {
            id: lineSeries2
            name: "Flow Test"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        LineSeries {
            id: lineSeries3
            name: "Leakage Test"
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
            var value1 = mainApp.value[position_keys[0]];
            var value2 = mainApp.value[flow_keys[0]];
            var value3 = mainApp.value[leakage_keys[0]];
            lineSeries1.append(lineSeries1.count, value1);
            lineSeries2.append(lineSeries2.count, value2);
            lineSeries3.append(lineSeries3.count, value3);

            // Scroll the x-axis
            if (lineSeries1.count > axisX.max - axisX.min) {
                axisX.min++;
                axisX.max++;
            }

            // Clean old data if necessary
            if (lineSeries1.count > 100) {
                lineSeries1.remove(0);
                lineSeries2.remove(0);
                lineSeries3.remove(0);
            }
        }
    }
}
