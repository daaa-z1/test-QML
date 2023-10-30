import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 640
    height: 480

    Rectangle {
        id: containerPage
        color: "#000080" // Warna biru tua sebagai warna latar belakang
        width: mainWindow.width // Lebar containerPage sama dengan lebar mainWindow
        height: mainWindow.height * 0.7 // Tinggi containerPage adalah 70% dari tinggi mainWindow

        StackView {
            id: stackView
            initialItem: "pages/Dashboard.qml"
            anchors.fill: parent

            // Properti popEnter dan popExit untuk mengatur animasi
            pushEnter: Transition {
                NumberAnimation { properties: "x"; from: -parent.width; to: 0; duration: 300 }
            }
            pushExit: Transition {
                NumberAnimation { properties: "x"; from: 0; to: parent.width; duration: 300 }
            }
        }
    }

    Rectangle {
        id: containerControl
        color: "#000080" // Warna biru tua sebagai warna latar belakang
        width: mainWindow.width // Lebar containerControl sama dengan lebar mainWindow
        height: mainWindow.height * 0.3 // Tinggi containerControl adalah 30% dari tinggi mainWindow
        anchors.top: containerPage.bottom

        GridLayout {
            id: gridLayout
            columns: 3 // Tiga kolom untuk grid
            anchors.fill: parent

            Rectangle { color: "#0000FF" } // Warna biru untuk kotak pertama
            Rectangle { color: "#0000CD" } // Warna biru medium untuk kotak kedua
            Rectangle { color: "#00008B" } // Warna biru gelap untuk kotak ketiga
        }
    }
}
