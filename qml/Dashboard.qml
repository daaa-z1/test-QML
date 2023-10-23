import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

Page {
    title: "Dashboard"

    ColumnLayout {
        spacing: 10
        anchors.fill: parent

        Gauge {
            id: pressureGauge
            value: 50
            minimumValue: 0
            maximumValue: 100
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Gauge {
            id: flowGauge
            value: 30
            minimumValue: 0
            maximumValue: 100
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Gauge {
            id: positionGauge
            value: 75
            minimumValue: 0
            maximumValue: 100
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter // Mengganti anchors.horizontalCenter
            Button {
                text: "Mulai"
                onClicked: {
                    // Kode untuk memulai pengukuran
                }
            }

            Button {
                text: "Berhenti"
                onClicked: {
                    // Kode untuk menghentikan pengukuran
                }
            }

            Button {
                text: "Simpan Data"
                onClicked: {
                    // Kode untuk menyimpan data
                }
            }
        }

        RowLayout {
            spacing: 10
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter // Mengganti anchors.horizontalCenter
            CheckBox {
                text: "Pengaturan Amplifier"
                checked: false
            }

            RangeSlider {
                from: 0
                to: 100
                stepSize: 1
                Layout.fillWidth: true
            }
        }
    }
}
