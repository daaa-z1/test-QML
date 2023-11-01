import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "controls"

ApplicationWindow {
    visible: true
    visibility: "FullScreen"

    Item {
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent

            Header {
                id: appHeader
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Rectangle {
                id: contentArea
                color: "transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true

                Loader {
                    id: pageLoader
                    anchors.fill: parent
                    sourceComponent: Qt.createComponent("pages/Dashboard.qml")
                }
            }

            RowLayout {
                id: controlArea
                spacing: 10
                Layout.fillHeight: true
                Layout.fillWidth: true

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
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }
}
