import QtQuick 2.11
import QtQuick.Controls 2.3

Page {
    title: "Dashboard"

    Column {
        spacing: 10
        anchors.centerIn: parent

        // Indikator Gauge untuk Parameter Pengujian
        Gauge {
            id: pressureGauge
            value: 0
            minimumValue: 0
            maximumValue: 100
            width: parent.width
            height: parent.height * 0.3
            label: "Tekanan (psi)"
        }

        Gauge {
            id: flowGauge
            value: 0
            minimumValue: 0
            maximumValue: 100
            width: parent.width
            height: parent.height * 0.3
            label: "Aliran Fluida (L/min)"
        }

        Gauge {
            id: positionGauge
            value: 0
            minimumValue: 0
            maximumValue: 100
            width: parent.width
            height: parent.height * 0.3
            label: "Posisi Servo Valve"
        }

        // Kontrol Output dari LabJack
        CheckBox {
            text: "Output Aktif"
            checked: false
        }

        // Tombol untuk Menyimpan Data
        Button {
            text: "Simpan Data"
            onClicked: {
                // Tambahkan logika untuk menyimpan data ke database
            }
        }

        // Tombol untuk Memulai/Pause Pembacaan Parameter
        Button {
            text: "Start"
            onClicked: {
                // Tambahkan logika untuk memulai atau menghentikan pembacaan parameter
            }
        }

        // Pengaturan Amplifier
        Label {
            text: "Pengaturan Amplifier"
            font.bold: true
        }

        Slider {
            id: amplifierSlider
            from: 0
            to: 100
            stepSize: 1
            value: 50
        }

        Text {
            text: "Output Ranges: " + amplifierSlider.value
        }

        // Tombol untuk Menyimpan Pengaturan
        Button {
            text: "Simpan Pengaturan"
            onClicked: {
                // Tambahkan logika untuk menyimpan pengaturan ke database
            }
        }
    }
}
