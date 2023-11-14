import QtQuick 2.15
import QtCharts 2.15
import QtQuick.Controls 2.15

Page {
    width: 640
    height: 480

    ChartView {
        id: chartView
        title: "Live Data"
        width: parent.width * 3 / 4
        height: parent.height
        antialiasing: true

        LineSeries {
            id: lineSeries1
            name: "Data 1"
            axisX: DateTimeAxis {
                format: "hh:mm:ss"
                tickCount: 10
            }
            axisY: ValueAxis {
                min: 0
                max: 5
            }
        }

        LineSeries {
            id: lineSeries2
            name: "Data 2"
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
            onClicked: {
                if (positionTestCheckBox.checked) {
                    mainApp.addTest(positionTestCheckBox.text)
                }
                if (flowTestCheckBox.checked) {
                    mainApp.addTest(flowTestCheckBox.text)
                }
                if (leakageTestCheckBox.checked) {
                    mainApp.addTest(leakageTestCheckBox.text)
                }
                mainApp.startReading()
            }
        }

        Button {
            id: stopButton
            text: "Stop"
            onClicked: mainApp.stopReading()
        }
    }

    Connections {
        target: mainApp
        function onGraphValue(data) { updateGraph(data); }
    }

    function updateGraph(data) {
        var now = new Date();
        lineSeries1.append(now, data[0]);
        lineSeries2.append(now, data[1]);
        if (lineSeries1.count() > 100) {
            lineSeries1.remove(0);
        }
        if (lineSeries2.count() > 100) {
            lineSeries2.remove(0);
        }
    }
}
