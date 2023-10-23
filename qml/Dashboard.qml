import QtQuick 2.11
import QtQuick.Controls 2.11
import QtQuick.Layouts 1.11

Page {
    title: "Dashboard"

    // Header dengan informasi
    header: RowLayout {
        id: headerLayout
        spacing: 10

        Label {
            text: "Aplikasi Uji Servo Valve"
        }

        Label {
            text: "Jenis Valve: " // Tambahkan kode untuk pilihan jenis valve
        }

        Label {
            text: "Tanggal: " + Qt.formatDateTime(new Date(), "dd/MM/yyyy")
        }

        Label {
            text: "Waktu: " + Qt.formatDateTime(new Date(), "hh:mm:ss")
        }
    }

    contentItem: ColumnLayout {
        anchors.fill: parent
        spacing: 10

        // Indikator Gauge untuk parameter pengujian
        Rectangle {
            width: parent.width
            height: parent.width
            color: "lightgray"
            border.color: "darkgray"
            radius: width / 2

            // Placeholder untuk indikator, atur nilainya sesuai data
            Text {
                text: "Parameter 1" // Ubah dengan parameter yang sesuai
                anchors.centerIn: parent
            }
        }

        Rectangle {
            width: parent.width
            height: parent.width
            color: "lightgray"
            border.color: "darkgray"
            radius: width / 2

            // Placeholder untuk indikator, atur nilainya sesuai data
            Text {
                text: "Parameter 2" // Ubah dengan parameter yang sesuai
                anchors.centerIn: parent
            }
        }

        // Kontrol Output dari LabJack
        Rectangle {
            width: parent.width
            height: parent.width
            color: "lightgray"
            border.color: "darkgray"
            radius: width / 2

            // Placeholder untuk kontrol Output, tambahkan kontrol sesuai kebutuhan
            Text {
                text: "Kontrol Output"
                anchors.centerIn: parent
            }
        }

        // Tombol untuk menyimpan data
        Button {
            text: "Simpan Data"
            onClicked: {
                // Tambahkan kode untuk menyimpan data ke database
            }
        }

        // Tombol untuk memulai/berhenti pembacaan parameter
        Button {
            text: "Start"
            onClicked: {
                // Tambahkan kode untuk memulai atau berhenti pembacaan parameter
            }
        }

        // Pengaturan Amplifier
        Rectangle {
            width: parent.width
            height: 50
            color: "lightgray"
            border.color: "darkgray"
            radius: 10

            // Placeholder untuk pengaturan amplifier, tambahkan kontrol sesuai kebutuhan
            Text {
                text: "Pengaturan Amplifier"
                anchors.centerIn: parent
            }
        }
    }
}
