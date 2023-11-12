import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.3
import QtQuick.Layouts 1.15

Page {
    id: page
    width: 640
    height: 480

    ChartView {
        id: chartView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.8
        antialiasing: true

        // Create a line series for the plot
        LineSeries {
            id: lineSeries
            name: "Test Data"
            axisX: ValueAxis {
                min: 0
                max: 60
            }
            axisY: ValueAxis {
                min: -10
                max: 10
            }
        }
    }

    ColumnLayout {
        id: radioButtons
        spacing: 10
        anchors.top: chartView.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.2

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
        target: backend  // Replace with the id of your backend object
        onNewValue: updatePlot(values)
    }

    function updatePlot(values) {
        // Clear the line series
        lineSeries.clear();

        // Check which test is selected and plot the corresponding values
        if (flowTestButton.checked) {
            // Replace with the indices for the Flow Test
            lineSeries.append(values[0], values[1]);
        } else if (positionTestButton.checked) {
            // Indices for the Position Test
            lineSeries.append(values[5], values[6]);
        } else if (pressureTestButton.checked) {
            // Replace with the indices for the Pressure Test
            lineSeries.append(values[2], values[3]);
        } else if (leakageTestButton.checked) {
            // Replace with the indices for the Leakage Test
            lineSeries.append(values[4], values[7]);
        }
    }
}
