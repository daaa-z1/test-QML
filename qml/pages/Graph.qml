import QtQuick 2.15
import QtCharts 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: 640
    height: 480

    ChartView {
        id: chartView
        title: "Live Data"
        width: parent.width * 3 / 4
        height: parent.height
        antialiasing: true

        LineSeries {
            id: lineSeries
            name: "Data"
            axisX: DateTimeAxis {
                format: "hh:mm:ss"
                tickCount: 10
            }
            axisY: ValueAxis {
                min: 0
                max: 5
            }
        }
    }

    Rectangle {
        id: inputSection
        width: parent.width / 4
        height: parent.height
        anchors.right: parent.right

        CheckBox {
            id: positionTestCheckBox
            text: "Position Test"
        }

        CheckBox {
            id: flowTestCheckBox
            text: "Flow Test"
        }

        CheckBox {
            id: leakageTestCheckBox
            text: "Leakage Test"
        }

        Button {
            id: startButton
            text: "Start"
            onClicked: mainApp.startReading()
        }
    }

    Connections {
        target: mainApp
        onNewValue: updateGraph(newValue)
        onMinValues: updateMin(minValues)
        onMaxValues: updateMax(maxValues)
    }

    function updateGraph(data) {
        var now = new Date();
        if (positionTestCheckBox.checked) {
            lineSeries.append(now, data[6]);
            lineSeries.append(now, data[7]);
        }
        if (flowTestCheckBox.checked) {
            lineSeries.append(now, data[0]);
            lineSeries.append(now, data[4]);
        }
        if (lineSeries.count() > 100) {
            lineSeries.remove(0);
        }
    }

    function updateMin(minValues) {
        // Update min values here
    }

    function updateMax(maxValues) {
        // Update max values here
    }
}
