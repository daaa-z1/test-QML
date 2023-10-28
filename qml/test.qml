import QtQuick 2.11
import QtQuick.Controls 2.4
import "pages"

ApplicationWindow {
    visible: true
    width: 640
    height: 480

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
            onClicked: {
                stackView.replace("pages/Dashboard.qml")
                switchPage("dashboardPage") // Ubah "dashboardPage" sesuai dengan nama ID halaman Dashboard.qml
            }
        }

        TabButton {
            text: "Graph"
            onClicked: {
                stackView.replace("pages/Graph.qml")
                switchPage("graphPage") // Ubah "graphPage" sesuai dengan nama ID halaman Graph.qml
            }
        }

        TabButton {
            text: "History"
            onClicked: {
                stackView.replace("pages/History.qml")
                switchPage("historyPage") // Ubah "historyPage" sesuai dengan nama ID halaman History.qml
            }
        }

    }
}
