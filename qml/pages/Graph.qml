import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.3

Page {
    visible: true
    width: 640
    height: 480
    title: "Servo Valve Test App"

    ChartView {
        id: chartView
        anchors.fill: parent
        legend.visible: false
        antialiasing: true

        LineSeries {
            id: lineSeries1
            name: "Current Voltage"
            XYPoint { x: 0; y: 0 }
        }

        LineSeries {
            id: lineSeries2
            name: "Actual"
            XYPoint { x: 0; y: 0 }
        }
    }

    Column {
        id: radioButtons
        spacing: 10
        RadioButton {
            id: flowTestButton
            text: "Flow Test"
        }

        RadioButton {
            id: positionTestButton
            text: "Position Test"
        }

        RadioButton {
            id: pressureTestButton
            text: "Pressure Test"
        }

        RadioButton {
            id: leakageTestButton
            text: "Leakage Test"
        }
    }

    Connections {
        target: mainApp
        onNewValue: {
            var values = newValue;
            if (flowTestButton.checked) {
                lineSeries1.clear();
                lineSeries1.append(values[5], values[3]);
            } else if (positionTestButton.checked) {
                lineSeries1.clear();
                lineSeries2.clear();
                lineSeries1.append(values[5], values[6]);
                lineSeries2.append(values[5], values[7]);
            } else if (pressureTestButton.checked) {
                lineSeries1.clear();
                lineSeries2.clear();
                lineSeries1.append(values[5], values[0]);
                lineSeries2.append(values[5], values[1]);
            } else if (leakageTestButton.checked) {
                lineSeries1.clear();
                lineSeries1.append(values[5], values[3]);
            }
        }
    }
}
