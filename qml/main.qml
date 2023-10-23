import QtQuick 2.11
import QtQuick.Controls 2.3

ApplicationWindow {
    visible: true
    width: screen.width
    height: screen.height
    title: "Aplikasi Uji Servo Valve Hydraulic"

    // Splash Screen
    Rectangle {
        id: splashScreen
        width: 350
        height: 350
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
        initialItem: Component {
            Dashboard {
                onReady: {
                    // Hilangkan splash screen setelah aplikasi siap
                    splashScreen.visible = false
                }
            }
        }
    }


    MenuBar {
        Menu {
            title: "File"
            MenuItem {
                text: "Dashboard"
                onTriggered: stackView.push("Dashboard.qml")
            }
            // MenuItem {
            //     text: "Graph"
            //     onTriggered: stackView.push("Graph.qml")
            // }
            // MenuItem {
            //     text: "History"
            //     onTriggered: stackView.push("History.qml")
            // }
            // MenuItem {
            //     text: "Pengaturan"
            //     onTriggered: stackView.push("Settings.qml")
            // }
        }
    }

    // Status Bar
    Component.onCompleted: {
        // Menambahkan status bar ke jendela aplikasi
        var statusBarItem = statusBar.addItem("StatusBarItem", statusBar.statusBar);
        statusBarItem.text = "Tanggal: " + new Date().toLocaleDateString();
    }
}
