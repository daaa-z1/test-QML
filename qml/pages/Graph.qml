import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage

    property var position_keys: ['curr_v', 'aktual']
    property var flow_keys: ['press_in', 'flow']
    property var leakage_keys: ['press_in', 'press_a', 'press_b', 'flow']
    
    property bool testing: false

    Timer {
        id: timer
        interval: 10000 // 10 seconds
        repeat: true
        running: false
        onTriggered: {
            if (testQueue.length > 0) {
                current_test = testQueue.shift();
                current_keys = getKeysForTest(current_test);
                for (var i = 0; i < chartView.series.length; i++) {
                    chartView.series[i].clear();
                }
            } else {
                testing = false;
                timer.running = false;
            }
        }
    }

    ChartView {
        id: chartView
        width: parent.width * 3 / 4
        height: parent.height
        anchors.left: parent.left
        theme: ChartView.ChartThemeDark
        antialiasing: true
        title: current_test

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

        Repeater {
            model: current_keys.length
            delegate: Component {
                LineSeries {
                    name: current_keys[index]
                    axisX: axisX
                    axisY: axisY
                    useOpenGL: true
                }
            }
        }

        Component.onCompleted: {
            // Connect to the valueChanged signal of mainApp
            mainApp.valueChanged.connect(updatePlot);
        }

        function updatePlot() {
            // Append the new value to the series
            for (var i = 0; i < current_keys.length; i++) {
                if (chartView.series.length > i) {
                    var value = mainApp.value[current_keys[i]];
                    chartView.series[i].append(chartView.series[i].count, value);
                }
            }

            // Scroll the x-axis
            if (chartView.series.length > 0 && chartView.series[0].count > axisX.max - axisX.min) {
                axisX.min++;
                axisX.max++;
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

            Button {
                text: "Submit"
                onClicked: {
                    // Handle the submit action here, e.g., save test data
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
                enabled: !testing && (checkBox1.checked || checkBox2.checked || checkBox3.checked)
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
                    // Start the timer
                    testing = true;
                    timer.running = true;
                    timer.start();
                }
            }
        }
    }

    function getKeysForTest(testType) {
        if (testType === "position") {
            return position_keys;
        } else if (testType === "flow") {
            return flow_keys;
        } else if (testType === "leakage") {
            return leakage_keys;
        }
        return [];
    }
}
