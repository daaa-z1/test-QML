import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {

    property var position_keys: ['curr_v', 'aktual']
    property var flow_keys: ['press_in', 'flow']
    property var leakage_keys: ['press_in', 'press_a', 'press_b', 'flow']
    property var testQueue: []
    property int testIndex: 0
    property int testCount: 0
    property var current_keys: []
    property bool testing: false

    ChartView {
        id: chartView
        width: parent.width * 3 / 4
        height: parent.height
        anchors.left: parent.left
        theme: ChartView.ChartThemeDark
        antialiasing: true

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
            id: lineSeries
            name: "Test"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        Component.onCompleted: {
            // Connect to the valueChanged signal of mainApp
            mainApp.valueChanged.connect(updatePlot);
        }

        function updatePlot() {
            // Append the new value to the series
            for (var i = 0; i < current_keys.length; i++) {
                var value = mainApp.value[current_keys[i]];
                lineSeries.append(lineSeries.count, value);
            }

            // Scroll the x-axis
            if (lineSeries.count > axisX.max - axisX.min) {
                axisX.min++;
                axisX.max++;
            }

            // Update the test count
            testCount++;
            if (testCount >= 100) {
                testCount = 0;
                testIndex++;
                if (testIndex >= testQueue.length) {
                    testIndex = 0;
                    testing = false;
                }
                if (testQueue[testIndex] === "position") {
                    current_keys = position_keys;
                } else if (testQueue[testIndex] === "flow") {
                    current_keys = flow_keys;
                } else if (testQueue[testIndex] === "leakage") {
                    current_keys = leakage_keys;
                }
            }
        }
    }

    // Input box
    Rectangle {
        id: inputBox
        width: parent.width / 4
        height: parent.height
        anchors.right: parent.right

        Column {
            anchors.fill: parent
            spacing: 10

            TextField {
                id: dateField
                placeholderText: "Tanggal"
            }

            TextField {
                id: timeField
                placeholderText: "Waktu"
            }

            TextField {
                id: customerField
                placeholderText: "Nama Customer"
            }

            TextField {
                id: projectField
                placeholderText: "Deskripsi Proyek"
            }

            Button {
                text: "Submit"
                onClicked: {
                    // Handle the submit action here
                }
            }

            CheckBox {
                id: checkBox1
                text: "Position Test"
                enabled: !testing
            }

            CheckBox {
                id: checkBox2
                text: "Flow Test"
                enabled: !testing
            }

            CheckBox {
                id: checkBox3
                text: "Leakage Test"
                enabled: !testing
            }

            Button {
                text: "Start"
                enabled: !testing
                onClicked: {
                    // Add the selected tests to the queue
                    testQueue = [];
                    if (checkBox1.checked) {
                        testQueue.push("position");
                    }
                    if (checkBox2.checked) {
                        testQueue.push("flow");
                    }
                    if (checkBox3.checked) {
                        testQueue.push("leakage");
                    }
                    // Reset the test index and count
                    testIndex = 0;
                    testCount = 0;
                    testing = true;
                }
            }
        }
    }
}
