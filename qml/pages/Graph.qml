import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage

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
            id: lineSeries1
            name: "Test 1"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        LineSeries {
            id: lineSeries2
            name: "Test 2"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        LineSeries {
            id: lineSeries3
            name: "Test 3"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        LineSeries {
            id: lineSeries4
            name: "Test 4"
            axisX: axisX
            axisY: axisY
            useOpenGL: true
        }

        Component.onCompleted: {
            lineSeries1.visible = false;
            lineSeries2.visible = false;
            lineSeries3.visible = false;
            lineSeries4.visible = false;
            mainApp.valueChanged.connect(updatePlot);
        }

        function updatePlot() {
            if (current_keys.length > 0) {
                var value1 = mainApp.value[current_keys[0]];
                lineSeries1.append(lineSeries1.count, value1);
            }
            if (current_keys.length > 1) {
                var value2 = mainApp.value[current_keys[1]];
                lineSeries2.append(lineSeries2.count, value2);
            }
            if (current_keys.length > 2) {
                var value3 = mainApp.value[current_keys[2]];
                lineSeries3.append(lineSeries3.count, value3);
            }
            if (current_keys.length > 3) {
                var value4 = mainApp.value[current_keys[3]];
                lineSeries4.append(lineSeries4.count, value4);
            }

            chartView.title = "Test " + (testIndex + 1) + ": " + testQueue[testIndex];

            lineSeries1.name = current_keys.length > 0 ? current_keys[0] : "";
            lineSeries2.name = current_keys.length > 1 ? current_keys[1] : "";
            lineSeries3.name = current_keys.length > 2 ? current_keys[2] : "";
            lineSeries4.name = current_keys.length > 3 ? current_keys[3] : "";

            lineSeries1.visible = testing && current_keys.length > 0;
            lineSeries2.visible = testing && current_keys.length > 1;
            lineSeries3.visible = testing && current_keys.length > 2;
            lineSeries4.visible = testing && current_keys.length > 3;

            // Scroll the x-axis
            if (lineSeries1.count > axisX.max - axisX.min) {
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

                    // Uncheck all checkboxes and reset title after all tests are finished
                    positionTestCheckBox.checked = false;
                    flowTestCheckBox.checked = false;
                    leakageTestCheckBox.checked = false;
                    chartView.title = "Test Completed";  // Set the title back to default

                    // Reset currentTest
                    currentTest = null;
                    axisX.min = 0;
                    axisX.max = testQueue.length * 10;
                } else {
                    // Set the currentTest for the next test
                    currentTest = testQueue[testIndex];
                    axisX.min = testIndex * 10;
                    axisX.max = (testIndex + 1) * 10;
                }
                if (testQueue[testIndex] === "Postion Test") {
                    current_keys = position_keys;
                } else if (testQueue[testIndex] === "Flow Test") {
                    current_keys = flow_keys;
                } else if (testQueue[testIndex] === "Leakage Test") {
                    current_keys = leakage_keys;
                }
                lineSeries1.clear();
                lineSeries2.clear();
                lineSeries3.clear();
                lineSeries4.clear();
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
                id: positionTestCheckBox
                text: "Position Test"
                enabled: !testing
            }

            CheckBox {
                id: flowTestCheckBox
                text: "Flow Test"
                enabled: !testing
            }

            CheckBox {
                id: leakageTestCheckBox
                text: "Leakage Test"
                enabled: !testing
            }

            Button {
                id: startButton
                text: testing ? "Testing..." : "Start"
                enabled: !testing && (positionTestCheckBox.checked || flowTestCheckBox.checked || leakageTestCheckBox.checked)
                onClicked: {
                    // Add the selected tests to the queue
                    testQueue = [];
                    if (positionTestCheckBox.checked) {
                        testQueue.push("Position Test");
                    }
                    if (flowTestCheckBox.checked) {
                        testQueue.push("Flow Test");
                    }
                    if (leakageTestCheckBox.checked) {
                        testQueue.push("Leakage Test");
                    }
                    // Reset the test index and count
                    testIndex = 0;
                    testCount = 0;
                    testing = true;
                    if (testQueue[testIndex] === "Position Test") {
                        current_keys = position_keys;
                    } else if (testQueue[testIndex] === "Flow Test") {
                        current_keys = flow_keys;
                    } else if (testQueue[testIndex] === "Leakage Test") {
                        current_keys = leakage_keys;
                    }
                }
            }
        }
    }
}
