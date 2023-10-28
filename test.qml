// File: main.qml
import QtQuick 2.9
import QtQuick.Controls 2.2
import "../qml/pages"

ApplicationWindow {
    visible: true
    width: 640
    height: 480

    StackView {
        id: stackView
        initialItem: Dashboard {}
        anchors.fill: parent
    }

    footer: TabBar {
        id: tabBar
        currentIndex: stackView.currentIndex

        TabButton {
            text: "Dashboard"
            onClicked: stackView.replace(Dashboard{})
        }

        TabButton {
            text: "Graph"
            onClicked: stackView.replace(Graph{})
        }

        TabButton {
            text: "History"
            onClicked: stackView.replace(History{})
        }
    }
}
