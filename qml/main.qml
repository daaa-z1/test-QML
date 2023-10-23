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
        initialItem: Loader {
            source: "Dashboard.qml"
        }
    }

    MenuBar {
        Menu {
            title: "Page"
            MenuItem {
                text: "Dashboard"
                onTriggered: {
                    stackView.push("Dashboard.qml");
                }
            }
            MenuItem {
                text: "Graph"
                onTriggered: stackView.push("Graph.qml");
            }
            MenuItem {
                text: "History"
                onTriggered: stackView.push("History.qml");
            }
            MenuItem {
                text: "Pengaturan"
                onTriggered: stackView.push("Settings.qml");
            }
        }
    }
}
