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
                        color: pageLoader.sourceComponent.pressed ? "#C0C0C0" : (pageLoader.sourceComponent.hovered ? "#D3D3D3" : "#EDEDED")
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        pageLoader.sourceComponent = Qt.createComponent("pages/Dashboard.qml")
                        for (var i = 0; i < pageLoader.sourceComponent.repeater.count; i++) {
                            var gauge = pageLoader.sourceComponent.repeater.itemAt(i).findChild("gauge" + i);
                            if (gauge) {
                                gauge.enabled = true;
                            }
                        }
                    }
                }

                Button {
                    text: "Graph"
                    background: Rectangle {
                        radius: 8
                        color: pageLoader.sourceComponent.pressed ? "#C0C0C0" : (pageLoader.sourceComponent.hovered ? "#D3D3D3" : "#EDEDED")
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        pageLoader.sourceComponent = Qt.createComponent("pages/Graph.qml")
                        for (var i = 0; i < pageLoader.sourceComponent.repeater.count; i++) {
                            var gauge = pageLoader.sourceComponent.repeater.itemAt(i).findChild("gauge" + i);
                            if (gauge) {
                                gauge.enabled = false;
                            }
                        }
                    }
                }

                Button {
                    text: "Setting"
                    background: Rectangle {
                        radius: 8
                        color: pageLoader.sourceComponent.pressed ? "#C0C0C0" : (pageLoader.sourceComponent.hovered ? "#D3D3D3" : "#EDEDED")
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        pageLoader.sourceComponent = Qt.createComponent("pages/History.qml")
                        for (var i = 0; i < pageLoader.sourceComponent.repeater.count; i++) {
                            var gauge = pageLoader.sourceComponent.repeater.itemAt(i).findChild("gauge" + i);
                            if (gauge) {
                                gauge.enabled = false;
                            }
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

                Column {
                    id: dataLayout
                    anchors.fill: parent
                    leftPadding: 10
                    topPadding: 30
                    spacing: parent.height * 0.1

                    RowLayout {
                        id: dataRow1
                        Layout.fillWidth: true
                        spacing: 10

                        Label {
                            text: "Pin 1"
                        }

                        ComboBox {
                            id: comboBox1
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "+24"; value: 'Relay1'}
                                ListElement{key: "+15"; value: 'Relay2'}
                            }
                            contentItem: Text {
                                rightPadding: comboBox1.indicator.width + comboBox1.spacing
                                font.bold: true
                                font: comboBox1.font
                                color: comboBox1.pressed ? "grey" : "black"
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState1(model.get(currentIndex).value, 1)
                                dataRow1.checkForNewElement()
                            }
                        }

                        Label {
                            text: "Pin 2"
                        }

                        ComboBox {
                            id: comboBox2
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "0V"; value: 'Relay1'}
                                ListElement{key: "-15"; value: 'Relay2'}
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState2(model.get(currentIndex).value, 1)
                                dataRow1.checkForNewElement()
                            }
                        }

                        Label {
                            text: "Pin 3"
                        }

                        ComboBox {
                            id: comboBox3
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "Enable"; value: 'Relay3'}
                                ListElement{key: "GND"; value: 'Relay4'}
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState3(model.get(currentIndex).value, 1)
                                dataRow1.checkForNewElement()
                            }
                        }

                        function checkForNewElement() {
                            if (comboBox1.currentText === "+15" && comboBox2.currentText === "-15") {
                                var alreadyExists = false;
                                for (var i = 0; i < comboBox3.model.count; i++) {
                                    if (comboBox3.model.get(i).value === "Relay2") {
                                        alreadyExists = true;
                                        break;
                                    }
                                }
                                if (!alreadyExists) {
                                    comboBox3.model.append({"key": "0V", "value": "Relay2"});
                                }
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Label {
                            text: "Pin 4"
                        }

                        ComboBox {
                            id: comboBox4
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "Reff +"; value: 'Relay5'}
                                ListElement{key: "Act Press"; value: 'Relay6'}
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState4(model.get(currentIndex).value, 1)
                            }
                        }

                        Label {
                            text: "Pin 5"
                        }

                        ComboBox {
                            id: comboBox5
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "Reff -"; value: 'Relay7'}
                                ListElement{key: "+24"; value: 'Relay8'}
                                ListElement{key: "Reff Q"; value: 'Relay9'}
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState5(model.get(currentIndex).value, 1)
                            }
                        }

                        Label {
                            text: "Pin 6"
                        }

                        ComboBox {
                            id: comboBox6
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "Actual Valve"; value: 'Relay10'}
                                ListElement{key: "Reff Pressure"; value: 'Relay11'}
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState6(model.get(currentIndex).value, 1)
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Label {
                            text: "Pin 7"
                        }

                        ComboBox {
                            id: comboBox7
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "0V"; value: 'Relay12'}
                                ListElement{key: "GND"; value: 'Relay13'}
                                ListElement{key: "Reff"; value: 'Relay14'}
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState7(model.get(currentIndex).value, 1)
                            }
                        }

                        Label {
                            text: "Pin 8"
                        }

                        ComboBox {
                            id: comboBox8
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "Ready Signal"; value: 'Relay15'}
                                ListElement{key: "Actual Pressure"; value: 'Relay16'}
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState8(model.get(currentIndex).value, 1)
                            }
                        }

                        Label {
                            text: "Pin 9"
                        }

                        ComboBox {
                            id: comboBox9
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "Signal Window"; value: 'Relay17'}
                                ListElement{key: "Reff Pressure"; value: 'Relay18'}
                                ListElement{key: "+24"; value: 'Relay19'}
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState9(model.get(currentIndex).value, 1)
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Label {
                            text: "Pin 10"
                        }

                        ComboBox {
                            id: comboBox10
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "GND"; value: 'Relay20'}
                                ListElement{key: "Actual Pressure"; value: 'Relay21'}
                                ListElement{key: "+24"; value: 'Relay22'}
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState10(model.get(currentIndex).value, 1)
                            }
                        }

                        Label {
                            text: "Pin 11"
                        }

                        ComboBox {
                            id: comboBox11
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "OUT 24V"; value: 'Relay23'}
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState11(model.get(currentIndex).value, 1)
                            }
                        }

                        Label {
                            text: "Reset All"
                        }

                        Button {
                            text: "Reset"
                            background: Rectangle {
                                color: control.pressed ? "#333" : "#444"
                                radius: 5
                                border.color: "#555"
                                border.width: 1
                                opacity: 1

                                DropShadow {
                                    horizontalOffset: 5
                                    verticalOffset: 5
                                    radius: 5
                                    samples: 5
                                    color: "#aa000000"
                                    source: parent
                                }
                            }

                            onClicked: {
                                for (var i = 0; i < dataLayout.children.length; i++) {
                                    var rowLayout = dataLayout.children[i];
                                    for (var j = 0; j < rowLayout.children.length; j++) {
                                        if (rowLayout.children[j] instanceof ComboBox) {
                                            rowLayout.children[j].currentIndex = 0
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
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
