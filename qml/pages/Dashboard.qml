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
                    minimumValue: getMinValue(index)
                    maximumValue: getMaxValue(index)
                }
            }
        }
    }

    function getMinValue(index) {
        var minValues = [min1, min2, min3, min4, min5, min6, min7, min8];
        return minValues[index];
    }

    function getMaxValue(index) {
        var maxValues = [max1, max2, max3, max4, max5, max6, max7, max8];
        return maxValues[index];
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
    }
}
