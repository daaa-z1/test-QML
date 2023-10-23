import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

ApplicationWindow {
    visible: true
    width: screen.width
    height: screen.height
    title: "Aplikasi Uji Servo Valve Hydraulic"

    // Splash Screen
    Rectangle {
        id: splashScreen
        width: parent.width
        height: parent.height
        color: "#1E2C3C" // Warna biru gelap
        visible: true

        Text {
            text: "Aplikasi Uji Servo Valve Hydraulic"
            font.pixelSize: 24
            color: "white"
            anchors.centerIn: parent
        }

        ProgressBar {
            id: splashProgressBarItem  // Ubah nama variabel ini menjadi splashProgressBarItem
            width: parent.width * 0.8
            height: 20
            anchors.centerIn: parent
            from: 0
            to: 100
            value: 0

            // Simulasikan loading screen selesai
            SequentialAnimation {
                NumberAnimation {
                    target: splashProgressBarItem  // Ubah target menjadi splashProgressBarItem
                    property: "value"
                    to: 100
                    duration: 3000 // Ubah durasi sesuai kebutuhan
                }

                onRunningChanged: {
                    if (!running) {
                        splashScreen.visible = false; // Hilangkan splash screen
                        stackView.push(dashboard); // Tampilkan dashboard
                    }
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: Item {
            visible: false

            Dashboard {
                id: dashboard
                anchors.fill: parent
                visible: false

                Component.onCompleted: {
                    // Aktifkan tampilan dashboard setelah splash screen selesai
                    visible = true;
                }
            }
        }
    }

    MenuBar {
        Menu {
            title: "Page"
            MenuItem {
                text: "Dashboard"
                onTriggered: stackView.push(dashboard);
            }
            // MenuItem {
            //     text: "Graph"
            //     onTriggered: stackView.push(Graph);
            // }
            // MenuItem {
            //     text: "History"
            //     onTriggered: stackView.push(History);
            // }
            // MenuItem {
            //     text: "Pengaturan"
            //     onTriggered: stackView.push(Settings);
            // }
        }
    }
}
