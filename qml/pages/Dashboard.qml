import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    ListModel {
        id: valueModel
    }

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: Math.ceil(valueModel.count / 2)

        Repeater {
            model: valueModel

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

                    value: model.value
                    minimumValue: minValues.get(index)
                    maximumValue: maxValues.get(index)
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            valueModel.clear()
            valueModel.append({ "value": value1 })
            valueModel.append({ "value": value2 })
            valueModel.append({ "value": value3 })
            valueModel.append({ "value": value4 })
            valueModel.append({ "value": value5 })
            valueModel.append({ "value": value6 })
            valueModel.append({ "value": value7 })
            valueModel.append({ "value": value8 })
        }
        
        function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            minValues.clear()
            minValues.append(min1)
            minValues.append(min2)
            minValues.append(min3)
            minValues.append(min4)
            minValues.append(min5)
            minValues.append(min6)
            minValues.append(min7)
            minValues.append(min8)
        }
        
        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            maxValues.clear()
            maxValues.append(max1)
            maxValues.append(max2)
            maxValues.append(max3)
            maxValues.append(max4)
            maxValues.append(max5)
            maxValues.append(max6)
            maxValues.append(max7)
            maxValues.append(max8)
        }
    }
}
