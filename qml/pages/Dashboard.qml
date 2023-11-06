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
    ListModel {
        id: minModel
    }
    ListModel {
        id: maxModel
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
            gaugeModel.append({"value": value1})
            gaugeModel.append({"value": value2})
            gaugeModel.append({"value": value3})
            gaugeModel.append({"value": value4})
            gaugeModel.append({"value": value5})
            gaugeModel.append({"value": value6})
            gaugeModel.append({"value": value7})
            gaugeModel.append({"value": value8})
        }
        
        function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            gaugeModel.get({"min": min1})
            gaugeModel.get({"min": min2})
            gaugeModel.get({"min": min3})
            gaugeModel.get({"min": min4})
            gaugeModel.get({"min": min5})
            gaugeModel.get({"min": min6})
            gaugeModel.get({"min": min7})
            gaugeModel.get({"min": min8})
        }
        function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            gaugeModel.get({"max": max1})
            gaugeModel.get({"max": max2})
            gaugeModel.get({"max": max3})
            gaugeModel.get({"max": max4})
            gaugeModel.get({"max": max5})
            gaugeModel.get({"max": max6})
            gaugeModel.get({"max": max7})
            gaugeModel.get({"max": max8})
        }
    }
}
