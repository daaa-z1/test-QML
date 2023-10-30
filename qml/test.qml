import QtQuick 2.11
import QtQuick.Controls 2.4

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
}
