import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

Page {
    title: "Dashboard"

    // Content Item
    Item {
        width: parent.width
        height: parent.height

        ColumnLayout {
            spacing: 10
            anchors.fill: parent

            Gauge {
                value: 50
                minimumValue: 0
                maximumValue: 100
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Gauge {
                value: 30
                minimumValue: 0
                maximumValue: 100
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Gauge {
                value: 75
                minimumValue: 0
                maximumValue: 100
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter

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
            anchors.horizontalCenter: parent.horizontalCenter

            CheckBox {
                text: "Pengaturan Amplifier"
                Layout.alignment: Qt.AlignLeft
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

    onStatusChanged: {
        if (status === PageStatus.Ready) {
            // Emit signal to inform main.qml that this page is ready
            onReady()
        }
    }
}
