// File: main.qml
import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480

    StackView {
        id: stackView
        initialItem: "qml/pages/Dashboard.qml"
        anchors.fill: parent
    }

    footer: TabBar {
        id: tabBar
        currentIndex: stackView.currentIndex

        TabButton {
            text: "Dashboard"
            onClicked: stackView.replace("qml/pages/Dashboard.qml")
        }

        TabButton {
            text: "Graph"
            onClicked: stackView.replace("qml/pages/Graph.qml")
        }

        TabButton {
            text: "History"
            onClicked: stackView.replace("qml/pages/History.qml")
        }
    }
}
