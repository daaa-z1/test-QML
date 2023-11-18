import QtQuick 2.15
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage

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
            LineSeries {
                id: positionSeries
                name: "Position"
                visible: false  // Initially hidden, will be shown when checkbox is checked
            }
            LineSeries {
                id: flowSeries
                name: "Flow"
                visible: false
            }
            LineSeries {
                id: leakageSeries
                name: "Leakage"
                visible: false
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
                padding: 10

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
                        positionSeries.visible = checkBox1.checked;
                        flowSeries.visible = checkBox2.checked;
                        leakageSeries.visible = checkBox3.checked;

                        // Start the tests
                        if (checkBox1.checked) {
                            positionSeries.clear();
                            for (var key in position_keys) {
                                positionSeries.append(new Date().getTime(), mainApp.value[position_keys[key]]);
                            }
                        }
                        if (checkBox2.checked) {
                            flowSeries.clear();
                            for (var key in flow_keys) {
                                flowSeries.append(new Date().getTime(), mainApp.value[flow_keys[key]]);
                            }
                        }
                        if (checkBox3.checked) {
                            leakageSeries.clear();
                            for (var key in leakage_keys) {
                                leakageSeries.append(new Date().getTime(), mainApp.value[leakage_keys[key]]);
                            }
                        }

                        // Start the timer
                        testTimer.start();
                    }
                }
            }
        }
    }
}
