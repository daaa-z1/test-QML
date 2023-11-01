import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "controls"

ApplicationWindow {
    visible: true
    visibility: "FullScreen"

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent

        Header {
            id: appHeader
        }

        Rectangle {
            id: contentArea
            // Layout.fillHeight: true
            Layout.fillWidth: true
            height: (mainLayout.height - appHeader.height) * 0.7
            anchors.top: appHeader.bottom
            color: "transparent"

            Loader {
                id: pageLoader
                anchors.fill: parent
                sourceComponent: Qt.createComponent("pages/Dashboard.qml")
            }

            Row {
                anchors{
                    horizontalCenter: parent.horizontalCenter
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

        RowLayout {
            id: controlArea
            spacing: 10
            // Layout.fillHeight: true
            height: appHeader.height - contentArea.height - appFooter.height
            Layout.fillWidth: true
            anchors.top: contentArea.bottom

            Rectangle {
                id: controlAmplifier
                color: "lightgray"
                border.color: "black"
                Layout.fillHeight: true
                Layout.fillWidth: true
                // Tambahkan komponen dari item controls di sini
            }

            Rectangle {
                id: config
                color: "lightgray"
                border.color: "black"
                Layout.fillHeight: true
                Layout.fillWidth: true
                // Tambahkan komponen dari item controls di sini
            }

            Rectangle {
                id: dataSection
                color: "lightgray"
                border.color: "black"
                Layout.fillHeight: true
                Layout.fillWidth: true
                // Tambahkan komponen dari item controls di sini
            }
        }

        Footer {
            id: appFooter
            anchors.bottom: parent.bottom
        }
    }
}
