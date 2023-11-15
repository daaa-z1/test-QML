import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import "controls"

ApplicationWindow {
    visible: true
    visibility: "FullScreen"

    ColumnLayout {
        anchors.fill: parent

        Header {
            id: appHeader
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
        }

        Rectangle {
            id: contentArea
            Layout.preferredHeight: (parent.height - appHeader.height - appFooter.height) * 0.7
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
                    background: Rectangle {
                        radius: 8
                        color: parent.pressed ? "#d3d3d3" : "#f0f0f0"
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        pageLoader.sourceComponent = Qt.createComponent("pages/Dashboard.qml")
                        for (var i = 0; i < repeater.count; i++) {
                            var gauge = repeater.itemAt(i).findChild("gauge" + i);
                            if (gauge) gauge.enabled = false;
                        }
                    }
                }
                Button {
                    text: "Graph"
                    background: Rectangle {
                        radius: 8
                        color: parent.pressed ? "#d3d3d3" : "#f0f0f0"
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        pageLoader.sourceComponent = Qt.createComponent("pages/Graph.qml")
                        for (var i = 0; i < repeater.count; i++) {
                            var gauge = repeater.itemAt(i).findChild("gauge" + i);
                            if (gauge) gauge.enabled = false;
                        }
                    }
                }
                Button {
                    text: "Setting"
                    background: Rectangle {
                        radius: 8
                        color: parent.pressed ? "#d3d3d3" : "#f0f0f0"
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        pageLoader.sourceComponent = Qt.createComponent("pages/History.qml")
                        for (var i = 0; i < repeater.count; i++) {
                            var gauge = repeater.itemAt(i).findChild("gauge" + i);
                            if (gauge) gauge.enabled = false;
                        }
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
                border.width: 1
                // Tambahkan komponen dari item controls di sini
            }

            Rectangle {
                id: config
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "lightgray"
                border.color: "black"
                border.width: 1
                // Tambahkan komponen dari item controls di sini
            }

            Rectangle {
                id: dataSection
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "lightgray"
                border.color: "black"
                border.width: 1
                // Tambahkan komponen dari item controls di sini
            }
        }
        Footer {
            id: appFooter
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignBottom
        }
    }
    Connections{
        target: mainApp
    }
}
