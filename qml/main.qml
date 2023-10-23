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
            // Tampilkan dashboard saat aplikasi dimulai
            Component.onCompleted: {
                var dashboardComponent = Qt.createComponent("Dashboard.qml");
                if (dashboardComponent.status === Component.Ready) {
                    var dashboard = dashboardComponent.createObject(stackView);
                    if (dashboard) {
                        stackView.push(dashboard);
                    }
                }
            }
        }
    }

    MenuBar {
        Menu {
            title: "Page"
            MenuItem {
                text: "Dashboard"
                onTriggered: {
                    var dashboardComponent = Qt.createComponent("Dashboard.qml");
                    if (dashboardComponent.status === Component.Ready) {
                        var dashboard = dashboardComponent.createObject(stackView);
                        if (dashboard) {
                            stackView.push(dashboard);
                        }
                    }
                }
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
