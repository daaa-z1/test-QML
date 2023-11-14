// main.qml

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: mainPage

    RowLayout {
        anchors.fill: parent

        // Grafik
        Graph {
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: !inputSection.positionTestChecked && !inputSection.flowTestChecked && !inputSection.leakageTestChecked
        }

        // Input Section
        Rectangle {
            id: inputSection
            Layout.prefWidth: parent.width * 0.3
            Layout.fillHeight: true
            
            color: "lightgray"

            ColumnLayout {
                anchors.fill: parent

                // Checkboxes
                CheckBox {
                    text: "Position Test"
                    id: positionTestCheckbox
                }

                CheckBox {
                    text: "Flow Test"
                    id: flowTestCheckbox
                }

                CheckBox {
                    text: "Leakage Test"
                    id: leakageTestCheckbox
                }

                // Start Button
                Button {
                    text: "Start"
                    onClicked: startTests()
                }
            }

            property bool positionTestChecked: positionTestCheckbox.checked
            property bool flowTestChecked: flowTestCheckbox.checked
            property bool leakageTestChecked: leakageTestCheckbox.checked

            function startTests() {
                if (positionTestChecked) {
                    mainApp.addTest("Position Test");
                }

                if (flowTestChecked) {
                    mainApp.addTest("Flow Test");
                }

                if (leakageTestChecked) {
                    mainApp.addTest("Leakage Test");
                }

                mainApp.startReading();
            }
        }
    }
}
