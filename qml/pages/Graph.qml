import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15
import QtQuick.Layouts 1.15

Page {
    visible: true

    property var position_keys: ['curr_v', 'aktual']
    property var flow_keys: ['pressure_in', 'flow']
    property var leakage_keys: ['pressure_in', 'pressure_a', 'pressure_b', 'flow']

    // Timer for tests
    Timer {
        id: testTimer
        interval: 10000  // 10 seconds
        repeat: true
        onTriggered: {
            if (positionSeries.visible) {
                positionSeries.visible = false;
                flowSeries.visible = checkBox2.checked;
            } else if (flowSeries.visible) {
                flowSeries.visible = false;
                leakageSeries.visible = checkBox3.checked;
            } else if (leakageSeries.visible) {
                leakageSeries.visible = false;
                positionSeries.visible = checkBox1.checked;
            }
        }
    }

    // Layout
    RowLayout {
        anchors.fill: parent

        // Chart
        ChartView {
            id: chart
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.75

            // Add series based on your data
            Repeater {
                model: position_keys.length
                delegate: LineSeries {
                    id: "positionSeries" + index
                    name: "Position " + index
                    visible: false
                }
            }
            Repeater {
                model: flow_keys.length
                delegate: LineSeries {
                    id: "flowSeries" + index
                    name: "Flow " + index
                    visible: false
                }
            }
            Repeater {
                model: leakage_keys.length
                delegate: LineSeries {
                    id: "leakageSeries" + index
                    name: "Leakage " + index
                    visible: false
                }
            }
        }

        // Input box
        Rectangle {
            id: inputBox
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.25
            color: "#f0f0f0"

            ColumnLayout {
                anchors.fill: parent
                spacing: 10
                Layout.margins: 10

                // Text fields
                TextField { id: tanggal; placeholderText: "Tanggal" }
                TextField { id: waktu; placeholderText: "Waktu" }
                TextField { id: customer; placeholderText: "Nama Customer" }
                TextField { id: deskripsi; placeholderText: "Deskripsi Proyek" }

                // Submit button
                Button {
                    text: "Submit"
                    onClicked: {
                        // Handle submit
                        console.log("Tanggal: " + tanggal.text);
                        console.log("Waktu: " + waktu.text);
                        console.log("Nama Customer: " + customer.text);
                        console.log("Deskripsi Proyek: " + deskripsi.text);
                        // TODO: Save these values for later use
                    }
                }

                // Check boxes
                CheckBox { id: checkBox1; text: "Position Test" }
                CheckBox { id: checkBox2; text: "Flow Test" }
                CheckBox { id: checkBox3; text: "Leakage Test" }

                // Start button
                Button {
                    text: "Start"
                    onClicked: {
                        // Handle start
                        for (var i = 0; i < position_keys.length; i++) {
                            var series = chart.series[i];
                            series.visible = checkBox1.checked;
                            if (checkBox1.checked && mainApp.value && mainApp.value[position_keys[i]]) {
                                series.clear();
                                series.append(new Date().getTime(), mainApp.value[position_keys[i]]);
                            }
                        }
                        for (var i = 0; i < flow_keys.length; i++) {
                            var series = chart.series[position_keys.length + i];
                            series.visible = checkBox2.checked;
                            if (checkBox2.checked && mainApp.value && mainApp.value[flow_keys[i]]) {
                                series.clear();
                                series.append(new Date().getTime(), mainApp.value[flow_keys[i]]);
                            }
                        }
                        for (var i = 0; i < leakage_keys.length; i++) {
                            var series = chart.series[position_keys.length + flow_keys.length + i];
                            series.visible = checkBox3.checked;
                            if (checkBox3.checked && mainApp.value && mainApp.value[leakage_keys[i]]) {
                                series.clear();
                                series.append(new Date().getTime(), mainApp.value[leakage_keys[i]]);
                            }
                        }

                        // Start the tests
                        testTimer.start();
                    }
                }
            }
        }
    }
}
