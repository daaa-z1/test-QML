import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    title: "Dashboard"
    background: Rectangle {
        color: "#1E2C3C" // Warna biru gelap sebagai primary
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        // Bagian Kiri (Gauge dan Output LabJack)
        GridLayout {
            columns: 3
            rowSpacing: 10
            columnSpacing: 10
            Layout.fillWidth: true

            Gauge {
                id: pressureGauge
                value: 0
                minimumValue: 0
                maximumValue: 100
                Label {
                    text: "Tekanan"
                    Layout.fillWidth: true
                }
            }

            Gauge {
                id: flowGauge
                value: 0
                minimumValue: 0
                maximumValue: 100
                Label {
                    text: "Aliran Fluida"
                    Layout.fillWidth: true
                }
            }

            Gauge {
                id: positionGauge
                value: 0
                minimumValue: 0
                maximumValue: 100
                Label {
                    text: "Posisi Aktual Servo Valve"
                    Layout.fillWidth: true
                }
            }

            // Output LabJack
            Button {
                text: "Start"
                onClicked: {
                    // Lakukan aksi saat tombol "Start" ditekan
                }
            }

            Button {
                text: "Stop"
                onClicked: {
                    // Lakukan aksi saat tombol "Stop" ditekan
                }
            }
        }

        // Bagian Kanan (Kontrol Simpan Data, Start/Stop, Pengaturan Amplifier)
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 10

            // Kontrol Simpan Data
            Button {
                text: "Simpan Data"
                onClicked: {
                    // Lakukan aksi saat tombol "Simpan Data" ditekan
                }
            }

            Button {
                text: "Start Pembacaan"
                onClicked: {
                    // Lakukan aksi saat tombol "Start Pembacaan" ditekan
                }
            }

            Button {
                text: "Stop Pembacaan"
                onClicked: {
                    // Lakukan aksi saat tombol "Stop Pembacaan" ditekan
                }
            }

            // Pengaturan Amplifier
            Label {
                text: "Pengaturan Amplifier"
            }

            // Kontrol Knob
            Slider {
                from: 0
                to: 100
                stepSize: 1
                value: 50
            }

            // Output Ranges
            Label {
                text: "Output Ranges"
            }

            Slider {
                from: 0
                to: 100
                stepSize: 1
                value: 50
            }
        }
    }
}
