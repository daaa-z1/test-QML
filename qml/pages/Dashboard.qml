import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    property var gaugeValues: [0, 0, 0, 0, 0, 0, 0, 0]

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: gaugeValues.length > 4 ? Math.ceil(gaugeValues.length / 2) : gaugeValues.length

        Repeater {
            model: gaugeValues.length

            Rectangle {
                id: container
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                radius: width * 0.1

                CircularGauge {
                    id: gauge
                    anchors.centerIn: parent
                    width: container.width * 0.8
                    height: width

                    value: gaugeValues[index]
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            gaugeValues = [value1, value2, value3, value4, value5, value6, value7, value8]
        }
    }
}
