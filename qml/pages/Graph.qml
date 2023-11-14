import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage
    Rectangle {
        id: graphContainer

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
                onCheckedChanged: {
                    if (checked) {
                        mainApp.addTest(text)
                    }
                }
            }

            CheckBox {
                id: flowTestCheckBox
                text: "Flow Test"
                onCheckedChanged: {
                    if (checked) {
                        mainApp.addTest(text)
                    }
                }
            }

            CheckBox {
                id: leakageTestCheckBox
                text: "Leakage Test"
                onCheckedChanged: {
                    if (checked) {
                        mainApp.addTest(text)
                    }
                }
            }

            Button {
                id: startButton
                text: "Start"
                onClicked: mainApp.startReading()
            }

            Button {
                id: stopButton
                text: "Stop"
                onClicked: mainApp.stopReading()
            }
        }

        Connections {
            target: mainApp
            onNewValue: updateGraph(graphValue)
        }

        function updateGraph(data) {
            var now = new Date();
            lineSeries.append(now, data[0]);
            lineSeries.append(now, data[1]);
            if (lineSeries.count() > 100) {
                lineSeries.remove(0);
            }
        }
    }
}
