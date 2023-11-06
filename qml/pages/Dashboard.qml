import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    property var values: [0, 0, 0, 0, 0, 0, 0, 0]
    property var minValues: [0, 0, 0, 0, 0, 0, 0, 0]
    property var maxValues: [0, 0, 0, 0, 0, 0, 0, 0]

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: Math.ceil(values.length / 2)

        Repeater {
            model: values

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

                    value: modelData
                    minimumValue: minValues[index]
                    maximumValue: maxValues[index]
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            values = [value1, value2, value3, value4, value5, value6, value7, value8]
        }

        function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            minValues = [min1, min2, min3, min4, min5, min6, min7, min8]
        }

        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            maxValues = [max1, max2, max3, max4, max5, max6, max7, max8]
        }
    }
}
