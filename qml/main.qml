import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "controls"

ApplicationWindow {
    visible: true
    visibility: "FullScreen"

    ColumnLayout {
        anchors.fill: parent

        Header {
            id: appHeader
            Layout.preferredHeight: contentHeight
        }

        Rectangle {
            id: contentArea
            Layout.fillHeight: true
            color: "transparent"
            Layout.fillWidth: true

            Loader {
                id: pageLoader
                anchors.fill: parent
                sourceComponent: Qt.createComponent("pages/Dashboard.qml")
            }

            RowLayout {
                Layout.preferredHeight: contentHeight
                Layout.fillWidth: true
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
            Layout.preferredHeight: contentHeight
            Layout.fillWidth: true
            spacing: 10

            Rectangle {
                id: controlAmplifier
                Layout.preferredHeight: controlArea.height
                Layout.fillWidth: true
                color: "lightgray"
                border.color: "black"
                // Tambahkan komponen dari item controls di sini
            }

            Rectangle {
                id: config
                Layout.preferredHeight: controlArea.height
                Layout.fillWidth: true
                color: "lightgray"
                border.color: "black"
                // Tambahkan komponen dari item controls di sini
            }

            Rectangle {
                id: dataSection
                Layout.preferredHeight: controlArea.height
                Layout.fillWidth: true
                color: "lightgray"
                border.color: "black"
                // Tambahkan komponen dari item controls di sini
            }
        }

        Footer {
            id: appFooter
            Layout.preferredHeight: contentHeight
        }
    }
}
