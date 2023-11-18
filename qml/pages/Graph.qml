import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Hydraulic Servo Valve Testing"

    property var position_keys: ['curr_v', 'aktual']
    property var flow_keys: ['pressure_in', 'flow']
    property var leakage_keys: ['pressure_in', 'pressure_a', 'pressure_b', 'flow']
    property var tests: []
    property var currentTest: 0

    function startTests() {
        if (tests.length > 0) {
            tests[currentTest].start();
        }
    }

    function nextTest() {
        if (currentTest + 1 < tests.length) {
            currentTest++;
            tests[currentTest].start();
        }
    }

    // Input Box
    Rectangle {
        id: inputBox
        width: parent.width / 4
        height: parent.height
        color: "#f0f0f0"

        Column {
            anchors.fill: parent
            spacing: 10
            padding: 10

            // Text Fields
            TextField { id: tanggal; placeholderText: "Tanggal" }
            TextField { id: waktu; placeholderText: "Waktu" }
            TextField { id: customer; placeholderText: "Nama Customer" }
            TextField { id: deskripsi; placeholderText: "Deskripsi Proyek" }

            // Submit Button
            Button {
                text: "Submit"
                onClicked: {
                    // Save the data for later use
                    mainApp.tanggal = tanggal.text;
                    mainApp.waktu = waktu.text;
                    mainApp.customer = customer.text;
                    mainApp.deskripsi = deskripsi.text;
                }
            }

            // Test Checkboxes and Start Button
            CheckBox { id: positionTest; text: "Position Test" }
            CheckBox { id: flowTest; text: "Flow Test" }
            CheckBox { id: leakageTest; text: "Leakage Test" }
            Button {
                text: "Start"
                onClicked: {
                    // Add the selected tests to the test queue
                    if (positionTest.checked) tests.push(mainApp.positionTest);
                    if (flowTest.checked) tests.push(mainApp.flowTest);
                    if (leakageTest.checked) tests.push(mainApp.leakageTest);

                    // Start the tests
                    startTests();
                }
            }
        }
    }

    // Chart
    ChartView {
        id: chart
        anchors.left: inputBox.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        // Series for each test
        LineSeries { id: positionSeries; name: "Position Test" }
        LineSeries { id: flowSeries; name: "Flow Test" }
        LineSeries { id: leakageSeries; name: "Leakage Test" }

        Component.onCompleted: {
            // Add the series to the chart
            chart.addSeries(positionSeries);
            chart.addSeries(flowSeries);
            chart.addSeries(leakageSeries);

            // Create axes
            chart.createDefaultAxes();
        }
    }

    Timer {
        id: timer
        interval: 1000
        repeat: true
        onTriggered: {
            // Update the series with the latest data
            positionSeries.append(new Date().getTime(), mainApp.value[position_keys[0]]);
            flowSeries.append(new Date().getTime(), mainApp.value[flow_keys[0]]);
            leakageSeries.append(new Date().getTime(), mainApp.value[leakage_keys[0]]);

            // Move to the next test after 10 seconds
            if (timer.runningTime > 10000) {
                nextTest();
            }
        }
    }
}
