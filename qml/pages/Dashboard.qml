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
                    // minimumValue: minModel.min
                    // maximumValue: maxModel.max
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
        
        // function onMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
        //     minModel.append({"min": min1})
        //     minModel.append({"min": min2})
        //     minModel.append({"min": min3})
        //     minModel.append({"min": min4})
        //     minModel.append({"min": min5})
        //     minModel.append({"min": min6})
        //     minModel.append({"min": min7})
        //     minModel.append({"min": min8})
        // }
        // function onMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
        //     maxModel.append({"max": max1})
        //     maxModel.append({"max": max2})
        //     maxModel.append({"max": max3})
        //     maxModel.append({"max": max4})
        //     maxModel.append({"max": max5})
        //     maxModel.append({"max": max6})
        //     maxModel.append({"max": max7})
        //     maxModel.append({"max": max8})
        // }
    }
}
