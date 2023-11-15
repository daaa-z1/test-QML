import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtCharts 2.15

Page {
    id: graphPage

    Rectangle {
        id: inputBox
        width: parent.width / 4
        height: parent.height
        anchors.right: parent.right

        ColumnLayout {
            anchors.fill: parent
            spacing: 10

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
                text: "Start"
                onClicked: {
                    if (positionTestCheckBox.checked) {
                        mainApp.startTest("Position Test");
                    } else if (flowTestCheckBox.checked) {
                        mainApp.startTest("Flow Test");
                    } else if (leakageTestCheckBox.checked) {
                        mainApp.startTest("Leakage Test");
                    }
                }
            }
        }
    }

    ChartView {
        id: chartView
        anchors {
            left: parent.left
            right: inputBox.left
            top: parent.top
            bottom: parent.bottom
        }

        LineSeries {
            id: positionTestSeries
            name: "Position Test"
            visible: false
        }

        LineSeries {
            id: flowTestSeries
            name: "Flow Test"
            visible: false 
        }

        LineSeries {
            id: leakageTestSeries
            name: "Leakage Test"
            visible: false 
        }
    }

    Timer {
        id: testTimer
        interval: 10000 // 10 seconds
        onTriggered: {
            positionTestSeries.visible = false;
            flowTestSeries.visible = false;
            leakageTestSeries.visible = false;

            // Show the current series
            if (positionTestCheckBox.checked && mainApp.currentTestIndex == 0) {
                positionTestSeries.visible = true;
            } else if (flowTestCheckBox.checked && mainApp.currentTestIndex == 1) {
                flowTestSeries.visible = true;
            } else if (leakageTestCheckBox.checked && mainApp.currentTestIndex == 2) {
                leakageTestSeries.visible = true;
            }

            // Update the current series
            mainApp.updateSeries();

            // Switch to the next test
            mainApp.switchTest();
        }
    }
}
