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
    Component {
        id: splashComponent

        Rectangle {
            width: parent.width
            height: parent.height
            color: "#1E2C3C" // Warna biru gelap

            Text {
                text: "Aplikasi Uji Servo Valve Hydraulic"
                font.pixelSize: 24
                color: "white"
                anchors.centerIn: parent
            }

            ProgressBar {
                width: parent.width * 0.8
                height: 20
                anchors.centerIn: parent
                from: 0
                to: 100
                value: 0

                // Simulasikan loading screen selesai
                SequentialAnimation {
                    NumberAnimation {
                        target: progressBar
                        property: "value"
                        to: 100
                        duration: 2000 // Ubah durasi sesuai kebutuhan
                    }

                    onRunningChanged: {
                        if (!running) {
                            stackView.push(dashboardComponent);
                        }
                    }
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: Item {
            Component.onCompleted: {
                stackView.push(splashComponent);
            }
        }
    }

    // Dashboard
    Component {
        id: dashboardComponent

        Dashboard {
            id: dashboard
        }
    }

    MenuBar {
        Menu {
            title: "Page"
            MenuItem {
                text: "Dashboard"
                onTriggered: stackView.push(dashboardComponent);
            }
            MenuItem {
                text: "Graph"
                onTriggered: stackView.push(Graph);
            }
            MenuItem {
                text: "History"
                onTriggered: stackView.push(History);
            }
            MenuItem {
                text: "Pengaturan"
                onTriggered: stackView.push(Settings);
            }
        }
    }
}
