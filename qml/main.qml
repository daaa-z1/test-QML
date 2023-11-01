import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    visibility: "FullScreen"

    header: Header {
        id: appHeader
        text: "Aplikasi Servo Valve"
        background: Rectangle {
            color: "#3498db"
            height: 30
        }
    }

    Rectangle {
        id: contentArea
        color: "transparent" 
        anchors.top: appHeader.bottom
        height: parent.height * 0.7
        width: parent.width

        Loader {
        id: pageLoader
        anchors.fill: parent
        sourceComponent: Qt.createComponent("pages/Dashboard.qml")
        }

        // Tombol untuk memuat halaman Dashboard
        Button {
            text: "Dashboard"
            onClicked: {
                pageLoader.sourceComponent = Qt.createComponent("pages/Dashboard.qml")
            }
        }

        // Tombol untuk memuat halaman Graph
        Button {
            text: "Graph"
            onClicked: {
                pageLoader.sourceComponent = Qt.createComponent("pages/Graph.qml")
            }
        }

        // Tombol untuk memuat halaman History
        Button {
            text: "History"
            onClicked: {
                pageLoader.sourceComponent = Qt.createComponent("pages/History.qml")
            }
        }
    }

    Rectangle {
        id: controlArea
        color: "lightgray" // Ganti dengan warna latar belakang yang Anda inginkan
        anchors.top: contentArea.bottom
        height: parent.height - contentArea.height - appFooter.height
        width: parent.width

        // Tambahkan bagian kontrol aplikasi LabJack di sini
    }

    Footer {
        id: appFooter
        text: "© 2023 Nama Anda"
        background: Rectangle {
            color: "#2c3e50" // Ganti dengan warna latar belakang yang Anda inginkan
            height: 30
        }
    }
}
