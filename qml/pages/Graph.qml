import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtCharts 2.3

Page {
    id: root

    property var position_keys: ['curr_v', 'aktual']
    property var flow_keys: ['press_in', 'flow']
    property var leakage_keys: ['press_in', 'press_a', 'press_b', 'flow']
    property bool testing: false
    property int testDuration: 10000 // 10 detik
    property int testInterval: 1000 // 1 detik
    property var testQueue: []
    property var currentTest: ""

    Timer {
        id: testTimer
        interval: root.testInterval
        repeat: true
        onTriggered: {
            var keys = [];
            if (currentTest === "Position Test") {
                keys = position_keys;
            } else if (currentTest === "Flow Test") {
                keys = flow_keys;
            } else if (currentTest === "Leakage Test") {
                keys = leakage_keys;
            }

            for (var i = 0; i < keys.length; i++) {
                var key = keys[i];
                var value = mainApp.value[key];
                var series = chartView.series(key);
                series.append(new Date().getTime(), value);
            }

            // Jika pengujian telah berlangsung selama 10 detik, lanjutkan ke pengujian berikutnya
            if (testTimer.runningTime >= testDuration) {
                testTimer.restart();
                if (testQueue.length > 0) {
                    currentTest = testQueue.shift();
                } else {
                    stopTesting();
                }
            }
        }
    }

    function startTesting() {
        testing = true;
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
        currentTest = testQueue.shift();
        testTimer.start();
    }

    function stopTesting() {
        testing = false;
        testTimer.stop();
    }

    Rectangle {
        id: graphArea
        width: root.width * 0.75
        height: root.height
        color: "#f0f0f0"

        QtCharts.ChartView {
            id: chartView
            anchors.fill: parent
            title: "Real-time Data"
            antialiasing: true

            function series(name) {
                for (var i = 0; i < chartView.series.length; i++) {
                    if (chartView.series[i].name === name) {
                        return chartView.series[i];
                    }
                }
                var newSeries = QtCharts.LineSeries {
                    name: name
                    axisX: QtCharts.DateTimeAxis {
                        format: "hh:mm:ss"
                    }
                    axisY: QtCharts.ValueAxis {
                        min: 0
                        max: 100
                    }
                }
                chartView.addSeries(newSeries);
                return newSeries;
            }
        }
    }

    Rectangle {
        id: inputBox
        width: root.width * 0.25
        height: root.height
        color: "#ffffff"
        anchors.right: root.right

        ColumnLayout {
            anchors.fill: parent
            spacing: 10
            padding: 10

            TextField {
                placeholderText: "Tanggal"
            }

            TextField {
                placeholderText: "Waktu"
            }

            TextField {
                placeholderText: "Nama Customer"
            }

            TextField {
                placeholderText: "Deskripsi Proyek"
            }

            Button {
                text: "Submit"
                Layout.alignment: Qt.AlignRight
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
                Layout.alignment: Qt.AlignRight
                enabled: !testing && (positionTestCheckBox.checked || flowTestCheckBox.checked || leakageTestCheckBox.checked)

                onClicked: {
                    if (testing) {
                        stopTesting();
                    } else {
                        startTesting();
                    }
                }
            }
        }
    }
}
