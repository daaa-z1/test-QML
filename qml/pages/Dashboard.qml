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

                    value: valueModel.get(index)
                    minimumValue: minValues[index]
                    maximumValue: maxValues[index]
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            valueModel.clear()
            valueModel.append(value1)
            valueModel.append(value2)
            valueModel.append(value3)
            valueModel.append(value4)
            valueModel.append(value5)
            valueModel.append(value6)
            valueModel.append(value7)
            valueModel.append(value8)
        }

        function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            minValues = [min1, min2, min3, min4, min5, min6, min7, min8]
        }

        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            maxValues = [max1, max2, max3, max4, max5, max6, max7, max8]
        }
    }
}
