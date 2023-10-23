import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

ApplicationWindow {
    visible: true
    width: Screen.desktopAvailableWidth // Menggunakan lebar layar desktop yang tersedia
    height: Screen.desktopAvailableHeight // Menggunakan tinggi layar desktop yang tersedia
    title: "Aplikasi Uji Servo Valve Hydraulic"

    // Splash Screen
    Rectangle {
        id: splashScreen
        width: parent.width // Menggunakan lebar layar
        height: parent.height // Menggunakan tinggi layar
        color: "#1E2C3C" // Warna biru gelap
        visible: true

        Text {
            id: splashText
            text: "Aplikasi Uji Servo Valve Hydraulic"
            font.pixelSize: 24
            color: "white"
            anchors.centerIn: parent
        }

        ProgressBar {
            id: splashProgressBar
            width: parent.width * 0.8
            height: 20
            anchors.centerIn: parent
            from: 0
            to: 100
            value: 0
        }
    }

    StackView {
        id: stackView
        initialItem: Dashboard {}
    }

    MenuBar {
        Menu {
            title: "Page"
            MenuItem {
                text: "Dashboard"
                onTriggered: stackView.push(Dashboard)
            }
            MenuItem {
                text: "Graph"
                onTriggered: stackView.push(Graph)
            }
            MenuItem {
                text: "History"
                onTriggered: stackView.push(History)
            }
            MenuItem {
                text: "Pengaturan"
                onTriggered: stackView.push(Settings)
            }
        }
    }

    Connections {
        target: stackView

        // Sembunyikan splash screen ketika halaman utama (Dashboard) sudah siap
        onStatusChanged: {
            if (stackView.currentItem.status === StackView.Ready) {
                splashScreen.visible = false;
            }
        }
    }
}
