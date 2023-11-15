import QtQuick 2.15
import QtCharts 2.15
import QtQuick.Controls 2.15

Page {
    id: graphPage

    Rectangle {
        id: inputSection
        width: parent.width / 4
        height: parent.height

        Column {
            anchors.fill: parent
            spacing: 10

            CheckBox {
                id: positionTestCheckBox
                text: "Position Test"
                onClicked: {
                    if (checked) {
                        mainApp.addTest("Position Test");
                    } else {
                        mainApp.removeTest("Position Test");
                    }
                }
            }

            CheckBox {
                id: flowTestCheckBox
                text: "Flow Test"
                onClicked: {
                    if (checked) {
                        mainApp.addTest("Flow Test");
                    } else {
                        mainApp.removeTest("Flow Test");
                    }
                }
            }

            CheckBox {
                id: leakageTestCheckBox
                text: "Leakage Test"
                onClicked: {
                    if (checked) {
                        mainApp.addTest("Leakage Test");
                    } else {
                        mainApp.removeTest("Leakage Test");
                    }
                }
            }

            Button {
                text: "Start Test"
                onClicked: {
                    mainApp.startReading();
                }
            }
        }
    }

    ChartView {
        id: chartView
        anchors.fill: parent

        LineSeries {
            name: "Graph Data"
            XYPoint { x: 0; y: 0 }
        }

        Component.onCompleted: {
            // Connect the series to the data
            for (var i = 0; i < mainApp.keys.length; ++i) {
                var series = chartView.series[i];
                series.name = mainApp.keys[i];
                series.clear();
            }

            mainApp.graphValue.connect(function (values) {
                for (var i = 0; i < values.length; ++i) {
                    chartView.series[i].append(i, values[i]);
                }
            });
        }
    }

    Timer {
        id: testTimer
        interval: 10000 // 10 seconds

        onTriggered: {
            if (positionTestCheckBox.checked) {
                mainApp.positionTest();
            } else if (flowTestCheckBox.checked) {
                mainApp.flowTest();
            } else if (leakageTestCheckBox.checked) {
                mainApp.leakageTest();
            }
        }
    }

    Component.onCompleted: {
        testTimer.start();
    }
}
