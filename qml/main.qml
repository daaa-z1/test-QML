import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

ApplicationWindow {
    visible: true
    width: screen.width
    height: screen.height
    title: "Aplikasi Uji Servo Valve Hydraulic"

    // StackView untuk tampilan
    StackView {
        id: stackView
        initialItem: Item {
            // Tampilkan splash screen saat aplikasi dimulai
            Timer {
                interval: 2000 // Durasi splash screen (dalam milidetik), sesuaikan dengan kebutuhan
                onTriggered: {
                    stackView.push(dashboardComponent);
                }
                running: true
                repeat: false
            }
        }
    }

    // Komponen Dashboard
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
