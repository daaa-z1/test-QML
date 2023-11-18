import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: graphPage

    property var position_keys: ['curr_v', 'aktual']
    property var flow_keys: ['pressure_in', 'flow']
    property var leakage_keys: ['pressure_in', 'pressure_a', 'pressure_b', 'flow']

    Timer {
        id: testTimer
        interval: 10000
        repeat: true
        onTriggered: {
            if (positionSeries.visible) {
                positionSeries.visible = true;
                flowSeries.visible = checkBox2.checked;
            } else if (flowSeries.visible) {
                flowSeries.visible = true;
                leakageSeries.visible = checkBox3.checked;
            } else if (leakageSeries.visible) {
                leakageSeries.visible = true;
                positionSeries.visible = checkBox1.checked;
            }
        }
    }

    RowLayout {
        anchors.fill: parent

        ChartView {
            id: chart
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.75

            LineSeries {
                id: positionSeries
                name: "Position"
                visible: false
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

        Rectangle {
            id: inputBox
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.25
            color: "#f0f0f0"

            ColumnLayout {
                anchors.fill: parent
                spacing: 10
                Layout.margins: 10

                TextField { id: tanggal; placeholderText: "Tanggal" }
                TextField { id: waktu; placeholderText: "Waktu" }
                TextField { id: customer; placeholderText: "Nama Customer" }
                TextField { id: deskripsi; placeholderText: "Deskripsi Proyek" }

                Button {
                    text: "Submit"
                    onClicked: {
                        console.log("Tanggal: " + tanggal.text);
                        console.log("Waktu: " + waktu.text);
                        console.log("Nama Customer: " + customer.text);
                        console.log("Deskripsi Proyek: " + deskripsi.text);
                        // TODO: Save these values for later use
                    }
                }

                CheckBox { id: checkBox1; text: "Position Test" }
                CheckBox { id: checkBox2; text: "Flow Test" }
                CheckBox { id: checkBox3; text: "Leakage Test" }

                Button {
                    text: "Start"
                    onClicked: {
                        positionSeries.visible = checkBox1.checked;
                        flowSeries.visible = checkBox2.checked;
                        leakageSeries.visible = checkBox3.checked;

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
                        testTimer.start();
                    }
                }
            }
        }
    }
}
