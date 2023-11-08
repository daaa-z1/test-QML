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
                    minimumValue: minMaxModel.get(index).min
                    maximumValue: minMaxModel.get(index).max
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

            minMaxModel.setProperty(0, "min", ainReader.minValues[0])
            minMaxModel.setProperty(0, "max", ainReader.maxValues[0])
            minMaxModel.setProperty(1, "min", ainReader.minValues[1])
            minMaxModel.setProperty(1, "max", ainReader.maxValues[1])
            minMaxModel.setProperty(2, "min", ainReader.minValues[2])
            minMaxModel.setProperty(2, "max", ainReader.maxValues[2])
            minMaxModel.setProperty(3, "min", ainReader.minValues[3])
            minMaxModel.setProperty(3, "max", ainReader.maxValues[3])
            minMaxModel.setProperty(4, "min", ainReader.minValues[4])
            minMaxModel.setProperty(4, "max", ainReader.maxValues[4])
            minMaxModel.setProperty(5, "min", ainReader.minValues[5])
            minMaxModel.setProperty(5, "max", ainReader.maxValues[5])
            minMaxModel.setProperty(6, "min", ainReader.minValues[6])
            minMaxModel.setProperty(6, "max", ainReader.maxValues[6])
            minMaxModel.setProperty(7, "min", ainReader.minValues[7])
            minMaxModel.setProperty(7, "max", ainReader.maxValues[7])
        }
    }

    ListModel {
        id: minMaxModel
        ListElement { min: 0; max: 100 }
        ListElement { min: 0; max: 100 }
        ListElement { min: 0; max: 100 }
        ListElement { min: 0; max: 100 }
        ListElement { min: 0; max: 100 }
        ListElement { min: -5; max: 5 }
        ListElement { min: -5; max: 5 }
        ListElement { min: -5; max: 5 }
    }
}
