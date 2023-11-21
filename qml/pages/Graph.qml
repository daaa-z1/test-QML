import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage

    property var position_keys: ['curr_v', 'aktual']
    property var flow_keys: ['press_in', 'flow']
    property var leakage_keys: ['press_in', 'press_a', 'press_b', 'flow']

    property var current_keys: []
    property bool testing: false

    Timer {
        id: timer
        interval: 10000 // 10 seconds
        repeat: true
        running: false
        onTriggered: {
            if (current_keys.length > 0) {
                for (var i = 0; i < chartView.series.length; i++) {
                    chartView.series[i].clear();
                }
                current_keys = [];
                testing = false;
                timer.running = false;
            } else {
                if (positionCheckBox.checked) {
                    current_keys = position_keys;
                } else if (flowCheckBox.checked) {
                    current_keys = flow_keys;
                } else if (leakageCheckBox.checked) {
                    current_keys = leakage_keys;
                }
                testing = true;
                timer.running = true;
                timer.start();
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
        title: testing ? "Testing..." : current_keys.length > 0 ? current_keys.join(", ") : "No Test"

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

            CheckBox {
                id: positionCheckBox
                text: "Position Test"
                enabled: !testing
            }

            CheckBox {
                id: flowCheckBox
                text: "Flow Test"
                enabled: !testing
            }

            CheckBox {
                id: leakageCheckBox
                text: "Leakage Test"
                enabled: !testing
            }

            Button {
                text: testing ? "Stop" : "Start"
                enabled: !testing && (positionCheckBox.checked || flowCheckBox.checked || leakageCheckBox.checked)
                onClicked: {
                    // Set the current keys and start/stop testing
                    timer.triggered();
                }
            }
        }
    }
}
