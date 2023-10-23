import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    title: "Dashboard"

    // Header dengan nama aplikasi, tanggal, waktu, dan jenis valve
    header: ToolBar {
        contentItem: Rectangle {
            height: parent.height
            width: parent.width

            Text {
                text: "Aplikasi Uji Servo Valve Hydraulic"
                font.pixelSize: 24
                anchors.centerIn: parent
            }
        }
    }

    // Bagian utama dengan indikator gauge, kontrol Output LabJack, dll.
    ScrollView {
        ColumnLayout {
            spacing: 10

            // Indikator Gauge
            Gauge {
                value: 50
                minimumValue: 0
                maximumValue: 100
                Label {
                    text: "Tekanan"
                }
            }

            Gauge {
                value: 30
                minimumValue: 0
                maximumValue: 100
                Label {
                    text: "Aliran Fluida"
                }
            }

            Gauge {
                value: 70
                minimumValue: 0
                maximumValue: 100
                Label {
                    text: "Posisi Aktual Servo Valve"
                }
            }

            // Kontrol Output LabJack
            Slider {
                value: 0
                minimumValue: -10
                maximumValue: 10
                Label {
                    text: "Output LabJack"
                }
            }

            // Tombol untuk menyimpan data dan mengatur amplifier
            RowLayout {
                Button {
                    text: "Simpan Data"
                }
                Button {
                    text: "Mulai Membaca Parameter"
                }
                Button {
                    text: "Pengaturan Amplifier"
                }
            }
        }
    }
}
