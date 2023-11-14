import QtQuick 2.15
import QtCharts 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

Page {
    width: 640
    height: 480

    GridLayout {
        columns: 2
        anchors.fill: parent

        ChartView {
            id: chartView
            title: "Live Data"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.columnSpan: 1
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
                
            }
        }

        Rectangle {
            id: inputSection
            Layout.preferredWidth: parent.width * 0.3
            Layout.fillHeight: true
            Layout.columnSpan: 1
            color: "#f0f0f0"

            DropShadow {
                anchors.fill: inputSection
                cached: true
                horizontalOffset: 3
                verticalOffset: 3
                radius: 8
                samples: 16
                color: "#80000000"
                source: inputSection
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20

                CheckBox {
                    id: positionTestCheckBox
                    text: "Position Test"
                    Layout.fillWidth: true
                }

                CheckBox {
                    id: flowTestCheckBox
                    text: "Flow Test"
                    Layout.fillWidth: true
                }

                CheckBox {
                    id: leakageTestCheckBox
                    text: "Leakage Test"
                    Layout.fillWidth: true
                }

                Button {
                    id: startStopButton
                    text: "Start"
                    Layout.fillWidth: true
                    enabled: positionTestCheckBox.checked || flowTestCheckBox.checked || leakageTestCheckBox.checked
                    background: Rectangle {
                        color: startStopButton.text === "Start" ? "green" : "red"
                    }
                    onClicked: {
                        if (text === "Start") {
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
                            text = "Stop"
                        } else {
                            mainApp.stopReading()
                            text = "Start"
                        }
                    }
                }
            }
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
