import QtQuick 2.15
import QtQuick.Controls 2.15
import "controls"

ApplicationWindow {
    visible: true
    visibility: "FullScreen"

    header: Header {
        id: appHeader
    }

    Rectangle {
        id: contentArea
        color: "transparent" 
        anchors.top: appHeader.bottom
        height: parent.height * 0.7
        width: parent.width

        Loader {
        id: pageLoader
        anchors.fill: parent
        sourceComponent: Qt.createComponent("pages/Dashboard.qml")
        }

        Row {
            anchors{
                left: contentArea.left
                bottom: contentArea.bottom
            }
            spacing: 10
            Button {
                text: "Dashboard"
                onClicked: {
                    pageLoader.sourceComponent = Qt.createComponent("pages/Dashboard.qml")
                }
            }
            Button {
                text: "Graph"
                onClicked: {
                    pageLoader.sourceComponent = Qt.createComponent("pages/Graph.qml")
                }
            }
            Button {
                text: "History"
                onClicked: {
                    pageLoader.sourceComponent = Qt.createComponent("pages/History.qml")
                }
            }
        }
    }

    Row {
        id: controlArea
        spacing: 10
        anchors.top: contentArea.bottom
        height: parent.height - contentArea.height - appFooter.height
        width: parent.width

        // Grid 1 untuk komponen dari item controls
        Rectangle {
            id: controlAmplifier
            width: parent.width/3
            color: "lightgray"
            border.color: "black" // Tambahkan border
            anchors {
                fill: parent
                left: parent.left
            }
            // Tambahkan komponen dari item controls di sini
        }

        // Grid 2 untuk komponen dari item controls
        Rectangle {
            id: config
            width: parent.width/3
            color: "lightgray"
            border.color: "black" // Tambahkan border
            anchors {
                fill: parent
                left: parent.left
            } 
            // Tambahkan komponen dari item controls di sini
        }

        // Grid 3 untuk komponen dari item controls
        Rectangle {
            id: dataSection
            width: parent.width/3
            color: "lightgray"
            border.color: "black" // Tambahkan border
            anchors {
                fill: parent
                left: parent.left
            }
            // Tambahkan komponen dari item controls di sini
        }
    }

    Footer {
        id: appFooter
    }
}
