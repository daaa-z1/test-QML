import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    property var valueData: {}
    property var minData: {}
    property var maxData: {}

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: Object.keys(valueData).length

        Repeater {
            model: Object.keys(valueData)

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

                    value: valueData[modelData]
                    minimumValue: minData[modelData]
                    maximumValue: maxData[modelData]
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            valueData = {
                value1: value1,
                value2: value2,
                value3: value3,
                value4: value4,
                value5: value5,
                value6: value6,
                value7: value7,
                value8: value8
            };
        }

        function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            minData = {
                value1: min1,
                value2: min2,
                value3: min3,
                value4: min4,
                value5: min5,
                value6: min6,
                value7: min7,
                value8: min8
            };
        }

        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            maxData = {
                value1: max1,
                value2: max2,
                value3: max3,
                value4: max4,
                value5: max5,
                value6: max6,
                value7: max7,
                value8: max8
            };
        }
    }
}
