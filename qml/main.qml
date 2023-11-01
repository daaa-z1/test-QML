import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "controls"

ApplicationWindow {
    visible: true
    visibility: "FullScreen"

    ColumnLayout {
        anchors.fill: parent

        Rectangle{
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            anchors.top: parent.top
            
            Header {
            id: appHeader
            }
        }

        Rectangle {
            id: contentArea
            Layout.preferredHeight: (parent.height - appHeader.height) * 0.7
            color: "transparent"
            Layout.fillWidth: true

            Loader {
                id: pageLoader
                anchors.fill: parent
                sourceComponent: Qt.createComponent("pages/Dashboard.qml")
            }

            RowLayout {
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
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

        RowLayout {
            id: controlArea
            Layout.preferredHeight: contentArea.height - appFooter.height
            Layout.fillWidth: true
            spacing: 10

            Rectangle {
                id: controlAmplifier
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "lightgray"
                border.color: "black"
                // Tambahkan komponen dari item controls di sini
            }

            Rectangle {
                id: config
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "lightgray"
                border.color: "black"
                // Tambahkan komponen dari item controls di sini
            }

            Rectangle {
                id: dataSection
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "lightgray"
                border.color: "black"
                // Tambahkan komponen dari item controls di sini
            }
        }

        Rectangle{
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            anchors.bottom: parent.bottom
            
            Footer {
            id: appFooter
            }
        }
    }
}
