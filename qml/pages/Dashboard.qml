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
            for (var i = 0; i < gaugeModel.count; i++) {
                gaugeModel.setProperty(i, "min", [min1, min2, min3, min4, min5, min6, min7, min8][i])
            }
        }
        
        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            for (var i = 0; i < gaugeModel.count; i++) {
                gaugeModel.setProperty(i, "max", [max1, max2, max3, max4, max5, max6, max7, max8][i])
            }
        }
    }
}
