// File: main.qml
import QtQuick 2.9
import QtQuick.Controls 2.2

import "pages"

ApplicationWindow {
    visible: true
    width: 640
    height: 480

    StackView {
        id: stackView
        initialItem: "../pages/Dashboard.qml"
        anchors.fill: parent
    }

    footer: TabBar {
        id: tabBar
        currentIndex: stackView.currentIndex

        TabButton {
            text: "Dashboard"
            onClicked: stackView.replace("../pages/Dashboard.qml")
        }

        TabButton {
            text: "Graph"
            onClicked: stackView.replace("../pages/Graph.qml")
        }

        TabButton {
            text: "History"
            onClicked: stackView.replace("../pages/History.qml")
        }
    }
}
