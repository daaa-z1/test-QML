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

    ListModel {
        id: minModel
    }

    ListModel {
        id: maxModel
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
                    minimumValue: minModel.get(index).min
                    maximumValue: maxModel.get(index).max
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
            minModel.clear()
            minModel.append({ "min": min1 })
            minModel.append({ "min": min2 })
            minModel.append({ "min": min3 })
            minModel.append({ "min": min4 })
            minModel.append({ "min": min5 })
            minModel.append({ "min": min6 })
            minModel.append({ "min": min7 })
            minModel.append({ "min": min8 })
        }

        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            maxModel.clear()
            maxModel.append({ "max": max1 })
            maxModel.append({ "max": max2 })
            maxModel.append({ "max": max3 })
            maxModel.append({ "max": max4 })
            maxModel.append({ "max": max5 })
            maxModel.append({ "max": max6 })
            maxModel.append({ "max": max7 })
            maxModel.append({ "max": max8 })
        }
    }
}
