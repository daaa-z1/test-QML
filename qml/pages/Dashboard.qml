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
                    
                    Component.onCompleted:{
                        minimumValue: minValue[index]
                        maximumValue: minValue[index]
                    }
                }
            }
        }
    }

    Connections {
        target: ainReader
        function onNewValue(value1, value2, value3, value4, value5, value6, value7, value8) {
            gaugeModel.clear()
            gaugeModel.append({"value": value1, "minValue": ainReader.minValues[0], "maxValue": ainReader.maxValues[0]})
            gaugeModel.append({"value": value2, "minValue": ainReader.minValues[1], "maxValue": ainReader.maxValues[1]})
            gaugeModel.append({"value": value3, "minValue": ainReader.minValues[2], "maxValue": ainReader.maxValues[2]})
            gaugeModel.append({"value": value4, "minValue": ainReader.minValues[3], "maxValue": ainReader.maxValues[3]})
            gaugeModel.append({"value": value5, "minValue": ainReader.minValues[4], "maxValue": ainReader.maxValues[4]})
            gaugeModel.append({"value": value6, "minValue": ainReader.minValues[5], "maxValue": ainReader.maxValues[5]})
            gaugeModel.append({"value": value7, "minValue": ainReader.minValues[6], "maxValue": ainReader.maxValues[6]})
            gaugeModel.append({"value": value8, "minValue": ainReader.minValues[7], "maxValue": ainReader.maxValues[7]})
        }
    }

}
