import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtCharts 2.3

Page {
    id: graphPage

    RowLayout {
        anchors.fill: parent

        ChartView {
            id: chartView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.75

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
                id: series1
                axisX: axisX
                axisY: axisY
            }

            LineSeries {
                id: series2
                axisX: axisX
                axisY: axisY
            }
        }

        Rectangle {
            id: inputSection
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.25
            color: "lightgray"
            border.color: "black"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                CheckBox {
                    id: positionTest
                    text: "Position Test"
                }

                CheckBox {
                    id: flowTest
                    text: "Flow Test"
                }

                CheckBox {
                    id: leakageTest
                    text: "Leakage Test"
                }

                Button {
                    text: "Start"
                    onClicked: {
                        var startTime = new Date();
                        var timer = new QTimer();
                        timer.interval = 1000; // Update every second
                        timer.timeout.connect(function() {
                            var currentTime = new Date();
                            var elapsedTime = (currentTime - startTime) / 1000; // Time in seconds

                            if (positionTest.checked) {
                                var value1 = mainApp.value['curr_v'];
                                var value2 = mainApp.value['aktual'];
                                series1.append(elapsedTime, value1);
                                series2.append(elapsedTime, value2);
                            }

                            if (flowTest.checked) {
                                var value1 = mainApp.value['pressure_in'];
                                var value2 = mainApp.value['flow'];
                                series1.append(elapsedTime, value1);
                                series2.append(elapsedTime, value2);
                            }

                            if (leakageTest.checked) {
                                var value1 = mainApp.value['pressure_in'];
                                var value2 = mainApp.value['flow'];
                                series1.append(elapsedTime, value1);
                                series2.append(elapsedTime, value2);
                            }

                            // Stop the test after 10 seconds
                            if (elapsedTime >= 10) {
                                timer.stop();
                            }
                        });
                        timer.start();
                    }
                }

            }
        }
    }
}
