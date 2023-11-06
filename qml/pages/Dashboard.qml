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
        switch (index) {
            case 0: return minValue1
            case 1: return minValue2
            case 2: return minValue3
            case 3: return minValue4
            case 4: return minValue5
            case 5: return minValue6
            case 6: return minValue7
            case 7: return minValue8
        }
    }

    function getMaxValue(index) {
        switch (index) {
            case 0: return maxValue1
            case 1: return maxValue2
            case 2: return maxValue3
            case 3: return maxValue4
            case 4: return maxValue5
            case 5: return maxValue6
            case 6: return maxValue7
            case 7: return maxValue8
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
            minValue1 = min1
            minValue2 = min2
            minValue3 = min3
            minValue4 = min4
            minValue5 = min5
            minValue6 = min6
            minValue7 = min7
            minValue8 = min8
        }

        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            maxValue1 = max1
            maxValue2 = max2
            maxValue3 = max3
            maxValue4 = max4
            maxValue5 = max5
            maxValue6 = max6
            maxValue7 = max7
            maxValue8 = max8
        }
    }
}
