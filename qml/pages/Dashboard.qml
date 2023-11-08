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
    ListModel{
        id: minModel
    }
    ListModel{
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
                    minimumValue: minModel.get(index).min
                    maximumValue: maxModel.get(index).max
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
        function onMinValues(value1, value2, value3, value4, value5, value6, value7, value8) {
            minModel.clear()
            minModel.append({"min": value1})
            minModel.append({"min": value2})
            minModel.append({"min": value3})
            minModel.append({"min": value4})
            minModel.append({"min": value5})
            minModel.append({"min": value6})
            minModel.append({"min": value7})
            minModel.append({"min": value8})
        }
        function onMaxValues(value1, value2, value3, value4, value5, value6, value7, value8) {
            maxModel.clear()
            maxModel.append({"max": value1})
            maxModel.append({"max": value2})
            maxModel.append({"max": value3})
            maxModel.append({"max": value4})
            maxModel.append({"max": value5})
            maxModel.append({"max": value6})
            maxModel.append({"max": value7})
            maxModel.append({"max": value8})
        }
    }
}
