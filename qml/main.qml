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
            Layout.margins: 10

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
                    id: dashboardBtn
                    width: 30
                    height: 10
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
                    id: graphBtn
                    width: 30
                    height: 10
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

                /* Button {
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
                } */

            }
        }

        RowLayout {
            id: controlArea
            Layout.preferredHeight: contentArea.height - appFooter.height
            Layout.fillWidth: true
            Layout.margins: 10
            spacing: 10

            Rectangle {
                id: updateParameter
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "lightgray"
                border.color: "black"
                border.width: 1

                ScrollView {
                    anchors.fill: parent
                    anchors.margins: 10
                    clip: true
                    ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                    Column {
                        id: paramLayout
                        spacing: 10
                        padding: 10

                        property var keys: ['press_in', 'press_a', 'press_b', 'flow', 'temp', 'curr_v', 'aktual', 'curr_ma', 'press_comm', 'press_actual']
                        property var parameters: ["Pressure In", "Pressure A", "Pressure B", "Flow", "Temperature", "Curr V", "Actual", "Curr MA", "Pressure Com", "Pressure Aktual"]

                        Repeater {
                            model: paramLayout.keys

                            Column {
                                spacing: 10

                                Row{
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    Label {
                                        text: "<b>" + paramLayout.parameters[index]
                                    }
                                }

                                Row {
                                    spacing: 10

                                    Label {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "Min Value:"
                                    }

                                    TextField {
                                        width: 50
                                        validator: IntValidator {bottom: -100}
                                        text: mainApp.parameter(modelData, 'minValue')
                                        onTextChanged: {
                                            if (text === '' || text === '-'){
                                                text = '0'
                                            }
                                            mainApp.updateParameter(modelData, 'minValue', parseFloat(text))
                                        }
                                    }

                                    Label {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "Max Value:"
                                    }

                                    TextField {
                                        width: 50
                                        validator: IntValidator {bottom: -100}
                                        text: mainApp.parameter(modelData, 'maxValue')
                                        onTextChanged: {
                                            if (text === '' || text === '-'){
                                                text = '1'
                                            }
                                            mainApp.updateParameter(modelData, 'maxValue', parseFloat(text))
                                        }
                                    }

                                    Label {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "Min Scale:"
                                    }

                                    TextField {
                                        width: 50
                                        validator: IntValidator {bottom: -100}
                                        text: mainApp.parameter(modelData, 'minScale')
                                        onTextChanged: {
                                            if (text === '' || text === '-'){
                                                text = '0'
                                            }
                                            mainApp.updateParameter(modelData, 'minScale', parseFloat(text))
                                        }
                                    }

                                    Label {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "Max Scale:"
                                    }

                                    TextField {
                                        width: 50
                                        validator: IntValidator {bottom: -100}
                                        text: mainApp.parameter(modelData, 'maxScale')
                                        onTextChanged: {
                                            if (text === '' || text === '-'){
                                                text = '1'
                                            }
                                            mainApp.updateParameter(modelData, 'maxScale', parseFloat(text))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }


            /* Rectangle {
                id: config
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "lightgray"
                border.color: "black"
                border.width: 1
                // Tambahkan komponen dari item controls di sini
            } */

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
                    anchors.margins: 10
                    spacing: parent.height * 0.1

                    RowLayout {
                        id: dataRow1
                        Layout.fillWidth: true
                        spacing: 10

                        Label {
                            text: "Pin 1"
                            font.bold: true
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
                                text: "<b>"+comboBox1.displayText
                                font: comboBox1.font
                                color: comboBox1.pressed ? "grey" : "black"
                                anchors.centerIn: parent
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
                            font.bold: true
                        }

                        ComboBox {
                            id: comboBox2
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "0V"; value: 'Relay1'}
                                ListElement{key: "-15"; value: 'Relay2'}
                            }
                            contentItem: Text {
                                rightPadding: comboBox2.indicator.width + comboBox2.spacing
                                text: "<b>"+comboBox2.displayText
                                font: comboBox2.font
                                color: comboBox2.pressed ? "grey" : "black"
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight
                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState2(model.get(currentIndex).value, 1)
                                dataRow1.checkForNewElement()
                            }
                        }

                        Label {
                            text: "Pin 3"
                            font.bold: true
                        }

                        ComboBox {
                            id: comboBox3
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "Enable"; value: 'Relay3'}
                                ListElement{key: "GND"; value: 'Relay4'}
                            }
                            contentItem: Text {
                                rightPadding: comboBox3.indicator.width + comboBox3.spacing
                                text: "<b>"+comboBox3.displayText
                                font: comboBox3.font
                                color: comboBox3.pressed ? "grey" : "black"
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight

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
                            font.bold: true
                        }

                        ComboBox {
                            id: comboBox4
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "Reff +"; value: 'Relay5'}
                                ListElement{key: "Act P"; value: 'Relay6'}
                            }
                            contentItem: Text {
                                rightPadding: comboBox4.indicator.width + comboBox4.spacing
                                text: "<b>"+comboBox4.displayText
                                font: comboBox4.font
                                color: comboBox4.pressed ? "grey" : "black"
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight

                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState4(model.get(currentIndex).value, 1)
                            }
                        }

                        Label {
                            text: "Pin 5"
                            font.bold: true
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
                            contentItem: Text {
                                rightPadding: comboBox5.indicator.width + comboBox5.spacing
                                text: "<b>"+comboBox5.displayText
                                font: comboBox5.font
                                color: comboBox5.pressed ? "grey" : "black"
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight

                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState5(model.get(currentIndex).value, 1)
                            }
                        }

                        Label {
                            text: "Pin 6"
                            font.bold: true
                        }

                        ComboBox {
                            id: comboBox6
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "Act V"; value: 'Relay10'}
                                ListElement{key: "Reff P"; value: 'Relay11'}
                            }
                            contentItem: Text {
                                rightPadding: comboBox6.indicator.width + comboBox6.spacing
                                text: "<b>"+comboBox6.displayText
                                font: comboBox6.font
                                color: comboBox6.pressed ? "grey" : "black"
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight

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
                            font.bold: true
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
                            contentItem: Text {
                                rightPadding: comboBox7.indicator.width + comboBox7.spacing
                                text: "<b>"+comboBox7.displayText
                                font: comboBox7.font
                                color: comboBox7.pressed ? "grey" : "black"
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight

                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState7(model.get(currentIndex).value, 1)
                            }
                        }

                        Label {
                            text: "Pin 8"
                            font.bold: true
                        }

                        ComboBox {
                            id: comboBox8
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "Ready"; value: 'Relay15'}
                                ListElement{key: "Act P"; value: 'Relay16'}
                            }
                            contentItem: Text {
                                rightPadding: comboBox8.indicator.width + comboBox8.spacing
                                text: "<b>"+comboBox8.displayText
                                font: comboBox8.font
                                color: comboBox8.pressed ? "grey" : "black"
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight

                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState8(model.get(currentIndex).value, 1)
                            }
                        }

                        Label {
                            text: "Pin 9"
                            font.bold: true
                        }

                        ComboBox {
                            id: comboBox9
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "Window"; value: 'Relay17'}
                                ListElement{key: "Reff P"; value: 'Relay18'}
                                ListElement{key: "+24"; value: 'Relay19'}
                            }
                            contentItem: Text {
                                rightPadding: comboBox9.indicator.width + comboBox9.spacing
                                text: "<b>"+comboBox9.displayText
                                font: comboBox9.font
                                color: comboBox9.pressed ? "grey" : "black"
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight

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
                            font.bold: true
                        }

                        ComboBox {
                            id: comboBox10
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "GND"; value: 'Relay20'}
                                ListElement{key: "Act P"; value: 'Relay21'}
                                ListElement{key: "+24"; value: 'Relay22'}
                            }
                            contentItem: Text {
                                rightPadding: comboBox10.indicator.width + comboBox10.spacing
                                text: "<b>"+comboBox10.displayText
                                font: comboBox10.font
                                color: comboBox10.pressed ? "grey" : "black"
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight

                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState10(model.get(currentIndex).value, 1)
                            }
                        }

                        Label {
                            text: "Pin 11"
                            font.bold: true
                        }

                        ComboBox {
                            id: comboBox11
                            textRole: "key"
                            model: ListModel {
                                ListElement{key: "Nothing"; value: 'nothing'}
                                ListElement{key: "OUT 24V"; value: 'Relay23'}
                            }
                            contentItem: Text {
                                rightPadding: comboBox11.indicator.width + comboBox11.spacing
                                text: "<b>"+comboBox11.displayText
                                font: comboBox11.font
                                color: comboBox11.pressed ? "grey" : "black"
                                anchors.centerIn: parent
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight

                            }
                            onCurrentIndexChanged: {
                                mainApp.setDOState11(model.get(currentIndex).value, 1)
                            }
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
        function onParameterChanged() {
            pageLoader.sourceComponent = Qt.createComponent("pages/Dashboard.qml")
            for (var i = 0; i < pageLoader.sourceComponent.repeater.count; i++) {
                var gauge = pageLoader.sourceComponent.repeater.itemAt(i).findChild("gauge" + i);
                if (gauge) {
                    gauge.enabled = true;
                }
            }
        }
    }
}
