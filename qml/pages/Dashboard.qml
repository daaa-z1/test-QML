import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

import "../controls"

Page {
    id: dashboardPage

    ListModel {
        id: gaugeModel
    }

    GridLayout {
        id: gridLayout
        anchors.fill: parent
        columns: gaugeModel.count > 4 ? Math.ceil(gaugeModel.count / 2) : gaugeModel.count

        Repeater {
            model: gaugeModel

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
                    minimumValue: model.min
                    maximumValue: model.max
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            gaugeModel.clear()
            gaugeModel.append({"value": value1, "min": gaugeModel.get(0).min, "max": gaugeModel.get(0).max})
            gaugeModel.append({"value": value2, "min": gaugeModel.get(1).min, "max": gaugeModel.get(1).max})
            gaugeModel.append({"value": value3, "min": gaugeModel.get(2).min, "max": gaugeModel.get(2).max})
            gaugeModel.append({"value": value4, "min": gaugeModel.get(3).min, "max": gaugeModel.get(3).max})
            gaugeModel.append({"value": value5, "min": gaugeModel.get(4).min, "max": gaugeModel.get(4).max})
            gaugeModel.append({"value": value6, "min": gaugeModel.get(5).min, "max": gaugeModel.get(5).max})
            gaugeModel.append({"value": value7, "min": gaugeModel.get(6).min, "max": gaugeModel.get(6).max})
            gaugeModel.append({"value": value8, "min": gaugeModel.get(7).min, "max": gaugeModel.get(7).max})
        }
        
        function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            gaugeModel.get(0).min = min1
            gaugeModel.get(1).min = min2
            gaugeModel.get(2).min = min3
            gaugeModel.get(3).min = min4
            gaugeModel.get(4).min = min5
            gaugeModel.get(5).min = min6
            gaugeModel.get(6).min = min7
            gaugeModel.get(7).min = min8
        }
        
        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            gaugeModel.get(0).max = max1
            gaugeModel.get(1).max = max2
            gaugeModel.get(2).max = max3
            gaugeModel.get(3).max = max4
            gaugeModel.get(4).max = max5
            gaugeModel.get(5).max = max6
            gaugeModel.get(6).max = max7
            gaugeModel.get(7).max = max8
        }
    }
}
