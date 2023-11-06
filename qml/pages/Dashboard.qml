import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: 4

        Repeater {
            model: 8

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

                    value: valueArray[index]
                    minimumValue: minArray[index]
                    maximumValue: maxArray[index]
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            valueArray = [value1, value2, value3, value4, value5, value6, value7, value8];
        }

        function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            minArray = [min1, min2, min3, min4, min5, min6, min7, min8];
        }

        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            maxArray = [max1, max2, max3, max4, max5, max6, max7, max8];
        }
    }

    property real valueArray: [0, 0, 0, 0, 0, 0, 0, 0]
    property real minArray: [0, 0, 0, 0, 0, 0, 0, 0]
    property real maxArray: [100, 100, 100, 100, 100, 100, 100, 100]
}
