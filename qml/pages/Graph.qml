import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Item {
    property var position_keys: ['curr_v', 'aktual']
    property var flow_keys: ['press_in', 'flow']
    property var leakage_keys: ['press_in', 'press_a', 'press_b', 'flow']

    // New properties for testing
    property bool isTesting: false
    property int currentTestIndex: 0
    property var testKeysList: [position_keys, flow_keys, leakage_keys]

    // Timer for testing
    Timer {
        id: testTimer
        interval: 10000 // 10 seconds
        repeat: true
        running: false
        onTriggered: {
            // Switch to the next test
            currentTestIndex = (currentTestIndex + 1) % testKeysList.length;
            // Restart the timer for the next test
            restart();
            // Start the next test
            startNextTest();
        }
    }

    // InputBox for data input and testing control
    ColumnLayout {
        id: inputBox
        width: parent.width / 4
        height: parent.height
        anchors.right: parent.right

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
                    // Handle empty fields
                }
            }
            background: Rectangle { color: "lightblue"; radius: 5 }
        }

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
            text: "Start Tests"
            onClicked: {
                if (positionTestCheckBox.checked || flowTestCheckBox.checked || leakageTestCheckBox.checked) {
                    if (positionTestCheckBox.checked) testQueue.push("Position Test");
                    if (flowTestCheckBox.checked) testQueue.push("Flow Test");
                    if (leakageTestCheckBox.checked) testQueue.push("Leakage Test");
                    startButton.enabled = false;
                    positionTestCheckBox.enabled = false;
                    flowTestCheckBox.enabled = false;
                    leakageTestCheckBox.enabled = false;
                    if (testData[currentTest] === undefined) {
                        createChart(currentTest);
                    }
                    startNextTest();
                } else {
                    // Handle no test selected
                }
            }
            background: Rectangle { color: "lightblue"; radius: 5 }
        }
    }

    // ChartView for displaying test results
    ChartView {
        id: chartView
        width: parent.width * 3 / 4
        height: parent.height
        antialiasing: true
        backgroundColor: "#f0f0f0"
        title: "Test Results"

        // Series for each test
        LineSeries {
            id: lineSeries
            XYPoint { x: 0; y: 0 }
        }
    }

    // Connections for updating the plot during testing
    Connections {
        target: mainApp
        onValueChanged: {
            // Update the plot only if testing is ongoing
            if (testTimer.running) {
                updatePlot();
            }
        }
    }

    // Function to create a new chart for the given test type
    function createChart(testType) {
        var keys = testKeysList[currentTestIndex];
        var currentTime = new Date().getTime();
        chartView.title = testType;

        for (var i = 0; i < keys.length; i++) {
            var key = keys[i];
            if (key) {
                var series = chartView.createSeries(ChartView.SeriesTypeLine, key, chartView.axisX(), chartView.axisY());
                series.append(currentTime, mainApp.value[key]);
            }
        }
    }

    // Function to update the plot during testing
    function updatePlot() {
        var keys = testKeysList[currentTestIndex];
        var currentTime = new Date().getTime();
        for (var i = 0; i < keys.length; i++) {
            var key = keys[i];
            if (key) {
                lineSeries.append(currentTime, mainApp.value[key]);
            }
        }
        // Scroll the x-axis
        if (lineSeries.count > chartView.axisX().max - chartView.axisX().min) {
            chartView.axisX().min++;
            chartView.axisX().max++;
        }
    }
}
