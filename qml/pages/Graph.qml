import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15
import QtQuick.Layouts 1.15

Page {
    visible: true

    ListModel {
        id: positionModel
        ListElement { key: 'curr_v' }
        ListElement { key: 'aktual' }
    }

    ListModel {
        id: flowModel
        ListElement { key: 'pressure_in' }
        ListElement { key: 'flow' }
    }

    ListModel {
        id: leakageModel
        ListElement { key: 'pressure_in' }
        ListElement { key: 'pressure_a' }
        ListElement { key: 'pressure_b' }
        ListElement { key: 'flow' }
    }

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
                model: positionModel
                delegate: LineSeries {
                    id: positionSeries
                    name: "Position " + index
                    visible: false
                }
            }
            Repeater {
                model: flowModel
                delegate: LineSeries {
                    id: flowSeries
                    name: "Flow " + index
                    visible: false
                }
            }
            Repeater {
                model: leakageModel
                delegate: LineSeries {
                    id: leakageSeries
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
                        for (var i = 0; i < positionModel.count; i++) {
                            var series = chart.series[i];
                            series.visible = checkBox1.checked;
                            if (checkBox1.checked) {
                                series.clear();
                                series.append(new Date().getTime(), mainApp.value[positionModel.get(i).key]);
                            }
                        }
                        for (var i = 0; i < flowModel.count; i++) {
                            var series = chart.series[positionModel.count + i];
                            series.visible = checkBox2.checked;
                            if (checkBox2.checked) {
                                series.clear();
                                series.append(new Date().getTime(), mainApp.value[flowModel.get(i).key]);
                            }
                        }
                        for (var i = 0; i < leakageModel.count; i++) {
                            var series = chart.series[positionModel.count + flowModel.count + i];
                            series.visible = checkBox3.checked;
                            if (checkBox3.checked) {
                                series.clear();
                                series.append(new Date().getTime(), mainApp.value[leakageModel.get(i).key]);
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
