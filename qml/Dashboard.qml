import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: dashboard

    header: ToolBar {
        contentItem: Text {
            text: "Dashboard"
            font.pixelSize: 24
        }
    }

    contentItem: ColumnLayout {
        spacing: 10
        anchors.fill: parent

        Gauge {
            id: pressureGauge
            value: 50 // Ganti dengan nilai tekanan aktual
            minimumValue: 0
            maximumValue: 100
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Gauge {
            id: flowGauge
            value: 30 // Ganti dengan nilai aliran fluida aktual
            minimumValue: 0
            maximumValue: 100
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Gauge {
            id: positionGauge
            value: 70 // Ganti dengan nilai posisi aktual servo valve
            minimumValue: 0
            maximumValue: 100
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        RowLayout {
            Button {
                text: "Save Data"
                onClicked: {
                    // Tambahkan logika untuk menyimpan data
                }
            }

            Button {
                text: "Start/Stop"
                onClicked: {
                    // Tambahkan logika untuk memulai atau menghentikan pembacaan parameter
                }
            }
        }

        ControlKnob {
            id: controlKnob
            value: 50 // Ganti dengan nilai kontrol knob
            minimumValue: 0
            maximumValue: 100
            Layout.fillWidth: true
            onValueChanged: {
                // Tambahkan logika untuk mengatur amplifier sesuai dengan kontrol knob
            }
        }

        RowLayout {
            Label {
                text: "Output Range:"
            }

            ComboBox {
                id: outputRangeComboBox
                model: ["Low", "Medium", "High"]
                currentIndex: 1 // Ganti sesuai dengan pengaturan yang sesuai
                onCurrentIndexChanged: {
                    // Tambahkan logika untuk mengubah rentang keluaran amplifier
                }
            }
        }
    }
}
