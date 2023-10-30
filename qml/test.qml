import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: Screen.width
    height: Screen.height
    color: "#000080" // Warna biru tua sebagai warna latar belakang

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

    footer: TabBar {
        id: tabBar
        currentIndex: stackView.currentIndex

        TabButton {
            text: "Dashboard"
            onClicked: stackView.push("pages/Dashboard.qml")
        }

        TabButton {
            text: "Graph"
            onClicked: stackView.push("pages/Graph.qml")
        }

        TabButton {
            text: "History"
            onClicked: stackView.push("pages/History.qml")
        }
    }

    Rectangle {
        id: container
        color: "#000080" // Warna biru tua sebagai warna latar belakang
        width: parent.width * 0.7 // Lebar container adalah 70% dari lebar jendela aplikasi
        height: parent.height * 0.7 // Tinggi container adalah 70% dari tinggi jendela aplikasi
        anchors.centerIn: parent

        GridLayout {
            id: gridLayout
            columns: 3 // Tiga kolom untuk grid
            anchors.bottom: parent.bottom // Grid berada di bagian bawah container
            width: parent.width // Lebar grid sama dengan lebar container
            height: parent.height * 0.3 // Tinggi grid adalah 30% dari tinggi container

            Rectangle { color: "#0000FF" } // Warna biru untuk kotak pertama
            Rectangle { color: "#0000CD" } // Warna biru medium untuk kotak kedua
            Rectangle { color: "#00008B" } // Warna biru gelap untuk kotak ketiga
        }
    }
}
