import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtCharts 2.15

Item {
    property bool isTesting: false
    property int currentTestIndex: 0
    property var testKeysList: [['curr_v', 'aktual'], ['press_in', 'flow'], ['press_in', 'press_a', 'press_b', 'flow']]

    Timer {
        id: testTimer
        interval: 10000 // 10 seconds
        repeat: true
        running: isTesting
        onTriggered: {
            currentTestIndex = (currentTestIndex + 1) % testKeysList.length;
            restart();
        }
    }

    RowLayout {
        id: inputBox
        width: parent.width / 4
        height: parent.height
        anchors.right: parent.right

        // First column for input data
        ColumnLayout {
            spacing: 10

            TextField {
                id: dateField
                text: Qt.formatDateTime(new Date(), "yyyy-MM-dd")
                readOnly: true
                background: Rectangle { color: "lightgray"; radius: 5 }
            }

            TextField {
                id: timeField
                text: Qt.formatDateTime(new Date(), "HH:mm:ss")
                readOnly: true
                background: Rectangle { color: "lightgray"; radius: 5 }
            }

            TextField {
                id: customerField
                placeholderText: "Customer Name"
                background: Rectangle { color: "lightgray"; radius: 5 }
            }

            TextField {
                id: projectField
                placeholderText: "Project Description"
                background: Rectangle { color: "lightgray"; radius: 5 }
            }

            Button {
                text: "Submit"
                onClicked: {
                    if (customerField.text.trim() !== "" && projectField.text.trim() !== "") {
                        testData = {
                            "Date": dateField.text,
                            "Time": timeField.text,
                            "Customer": customerField.text,
                            "Project": projectField.text
                        };
                    } else {
                    }
                }
                background: Rectangle { color: "lightblue"; radius: 5 }
            }
        }

        ColumnLayout {
            id: inputBoxCheckBoxes
            spacing: 10
            visible: false

            CheckBox {
                text: "Position Test"
                checked: currentTestIndex === 0
                onClicked: {
                    currentTestIndex = 0;
                    isTesting = true;
                }
            }

            CheckBox {
                text: "Flow Test"
                checked: currentTestIndex === 1
                onClicked: {
                    currentTestIndex = 1;
                    isTesting = true;
                }
            }

            CheckBox {
                text: "Leakage Test"
                checked: currentTestIndex === 2
                onClicked: {
                    currentTestIndex = 2;
                    isTesting = true;
                }
            }

            Button {
                text: "Start"
                onClicked: {
                    isTesting = true;
                }
            }
        }
    }

    // ChartView for displaying line charts
    ChartView {
        id: chartView
        width: parent.width * 3 / 4
        height: parent.height
        anchors.left: parent.left

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
            id: testLineSeries
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        // Modified updatePlot function
        function updatePlot() {
            var keys = testKeysList[currentTestIndex];
            for (var i = 0; i < keys.length; ++i) {
                var value = mainApp.value[keys[i]];
                testLineSeries.append(testLineSeries.count, value);
            }

            // Scroll the x-axis
            if (testLineSeries.count > axisX.max - axisX.min) {
                axisX.min++;
                axisX.max++;
            }

            // Clean old data if necessary
            if (testLineSeries.count > 100) {
                testLineSeries.remove(0);
            }
        }

        Timer {
            interval: 10000 // 10 seconds
            running: isTesting
            onTriggered: {
                isTesting = false;
            }
        }

        Connections {
            target: mainApp
            onValueChanged: {
                if (isTesting) {
                    updatePlot();
                }
            }
        }
    }
}
