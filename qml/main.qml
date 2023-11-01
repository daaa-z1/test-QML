import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "controls"

ApplicationWindow {
    visible: true
    visibility: "FullScreen"

    GridLayout{
        id: structureApp
        columns: 1

            Header {
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

            RowLayout {
                id: controlArea
                spacing: 10
                anchors.top: contentArea.bottom
                height: parent.height - contentArea.height - appFooter.height
                width: parent.width

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
            }
    }

}
