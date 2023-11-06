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
                    minimumValue: ainReader.minValue[index]
                    maximumValue: ainReader.maxValue[index]
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
        function onUpdateMinValues(min1, min2, min3, min4, min5, min6, min7, min8) {
            for (var i = 0; i < gaugeModel.count; i++) {
                gaugeModel.get(i).minValue = i == 0 ? min1 : i == 1 ? min2 : i == 2 ? min3 : i == 3 ? min4 : i == 4 ? min5 : i == 5 ? min6 : i == 6 ? min7 : min8;
            }
        }
        function onUpdateMaxValues(max1, max2, max3, max4, max5, max6, max7, max8) {
            for (var i = 0; i < gaugeModel.count; i++) {
                gaugeModel.get(i).maxValue = i == 0 ? max1 : i == 1 ? max2 : i == 2 ? max3 : i == 3 ? max4 : i == 4 ? max5 : i == 5 ? max6 : i == 6 ? max7 : max8;
            }
        }
    }
}
